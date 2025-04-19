// ActionStruct	Definicja co ma się wydarzyć	Atakuj tile[5, 3]
// ActionContextStruct	Jakie są warunki dookoła akcji	Kto jest celem, jakie efekty są aktywne
// ResolvedActionStruct	Kompletna akcja + wykonanie	resolved.apply()

function Action_TEMPLETE() 
{
	var ACTION_PROPERTIES = 
	{
		ACTION_TYPE_ID: ACTION_TYPE_ENUM.ATTACK,
		INVOKER_CHAR: noone, // character
		DESTINATION_TILE: noone, // TileClass
		ACTION_COST: function(SKILL_TYPE_VAR) {}
	}
}

/// @param {Id.Instance<Id.Instance.AbstTurnEntity>} turnEntity
/// @param {Enum.ACTION_INTENT_ENUM} intent_id
/// @returns {Struct.ActionStruct}
function resolveActionFromIntent(intent_id, turnEntity) {
	var pos = get_target_position_from_intent(intent_id, turnEntity);
	var row = pos[0];
	var col = pos[1];

	var targetTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(row, col)

	var ACTION_TYPE_ID = resolve_skill_type(turnEntity, targetTile);


	var actionStruct = new ActionStruct(ACTION_TYPE_ID, turnEntity, targetTile, intent_id)

	return buildActionStruct(turnEntity, targetTile, ACTION_TYPE_ID);
}



function get_target_position_from_intent(intent_id, character) {
	var row = character.properties_map_element_row_index;
	var col = character.properties_map_element_col_index;

	if (intent_id == ACTION_INTENT_ENUM.STAND) {
		return [row, col];
	}

	var vDirection = get_direction_from_intent(intent_id);

	if (vDirection != noone) {
		return helper_calculate_row_and_col_for_direction(vDirection, row, col);
	}

	// Fallback
	return [row, col];
}

/// @function resolve_skill_type
/// @param {Id.Instance<Id.Instance.AbstTurnEntity>} turnEntity
/// @param {Struct.MyMapTile} tile
/// @returns {Enum.ACTION_TYPE_ENUM}
function resolve_skill_type(turnEntity, tile) {
	var target_character = tile.getTurnEntityObj();
	if (helper_object_not_exists(target_character)) {
	    return ACTION_TYPE_ENUM.STEP;
	}
	
	if(target_character == turnEntity) {
		return ACTION_TYPE_ENUM.STAND;
	} else {
	    return ACTION_TYPE_ENUM.ATTACK;
	}

}

function buildActionStruct(character, tile, param_ACTION_TYPE_ENUM) {
	return {
		ACTION_TYPE_ID: param_ACTION_TYPE_ENUM,
		INVOKER_CHAR: character,
		DESTINATION_TILE: tile,
		ACTION_COST: function() {
			switch (ACTION_TYPE_ID) {
			    case ACTION_TYPE_ENUM.STEP:
			        return INVOKER_CHAR.stats.STEP.COST.BASE;
			    case ACTION_TYPE_ENUM.ATTACK:
			        return 3;
			}
			return 0;
		}
	};
}


/// @function ActionStruct
/// @desc Tworzy nową strukturę akcji w systemie walki.
///       Akcja definiuje typ działania (atak, ruch, itd.), 
// 		  ActionStruct	Definicja co ma się wydarzyć	Atakuj tile[5, 3]
///       inicjatora, cel oraz dane pomocnicze takie jak głębokość rekurencji.
/// @constructor
///
/// @param {Enum.ACTION_TYPE_ENUM} _type - Obiekt reprezentujący typ akcji (np. global.ENUMS.ACTION_TYPE.ATTACK)
/// @param {Id.Instance<Id.Instance.AbstTurnEntity>} _invoker - Obiekt postaci wykonującej akcję.
/// @param {Struct.MyMapTile} _target_tile - Kafelek, na który akcja jest skierowana.
/// @param {ActionIntentId} _from_intent - Intencja, z której wynikła ta akcja.
///
/// @returns {Struct.ActionStruct}
function ActionStruct(_type, _invoker, _target_tile, _from_intent) constructor {
	// Priv
	__id = helperGenerateUniqueId();
	__type = _type; 		// enum ACTION_TYPE
	__invoker = _invoker;
	__target_tile = _target_tile;
	__from_intent = _from_intent;
	__parent_action = noone;
	__origin_action = noone;
	__recursion_depth = 0;

	// Getters
	getId = function() { return __id; };
	getType = function() { return __type; };
	getInvoker = function() { return __invoker; };
	getTargetTile = function() { return __target_tile; };
	getFromIntent = function() { return __from_intent; };
	getParentAction = function() { return __parent_action; };
	getOriginAction = function() { return __origin_action; };
	getRecursionDepth = function() { return __recursion_depth; };
}

function ActionContextStruct(_invoker, _target, _tile, _mode) {
	return {
		invoker: _invoker,                       // zazwyczaj to samo co action.invoker
		target: _target,                         // postać stojąca na tile (jeśli jest)
		tile: _tile,                             // referencja do kafelka
		evaluation_mode: _mode,                  // enum: SIMULATION / PREDICTION / REAL_EXECUTION

		effects: [],                             // wszystkie aktywne efekty invokera
		target_effects: [],                      // aktywne efekty celu (jeśli istnieje)

		// przyszłościowo (opcjonalnie)
		source_intent: undefined,                // np. do logów / AI
		metadata: {},                            // miejsce na dodatkowe dane
	};
}

function ResolvedActionStruct(_action_struct, _context_struct) {
	return {
		action_struct: _action_struct,
		context_struct: _context_struct,

		calculate_cost: function() {
			return calculate_action_cost(self); // delegacja do logiki kosztów
		},

		// przydatne w predykcji np. w UI
		predict_result: function() {
			return predict_action_result(self); // np. oblicz ile dmg zada
		},

		// wykonanie
		apply: function() {
			return execute_action(self); // egzekucja efektu akcji
		}
	};
}