// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

function Action_TEMPLETE() 
{
	var ACTION_PROPERTIES = 
	{
		ACTION_TYPE_ID: ACTION_TYPE.ATTACK,
		INVOKER_CHAR: noone, // character
		DESTINATION_TILE: noone, // TileClass
		ACTION_COST: function(SKILL_TYPE_VAR) {}
	}
}

function resolve_action_from_intent(intent_id, character) {
	var pos = get_target_position_from_intent(intent_id, character);
	var row = pos[0];
	var col = pos[1];

	var tile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(row, col)
    
	
	var testowe = MyCombatMapHolder(0, 0);

	// testowe
	// testowe.

	/// @is MyCombatMapHolder
	var ACTION_TYPE_ID = resolve_skill_type(character, tile);

	return build_action_struct(character, tile, ACTION_TYPE_ID);
}



function get_target_position_from_intent(intent_id, character) {
	var row = character.properties_map_element_row_index;
	var col = character.properties_map_element_col_index;

	if (intent_id == ActionIntentId.STAND) {
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
/// @param {number} character - Liczba wierszy
/// @param {Struct.MyMapTile} tile
function resolve_skill_type(character, tile) {

	var target_character = tile.__character;
	if (helper_object_not_exists(target_character)) {
	    return ACTION_TYPE.STEP;
	}
	
	if(target_character == character) {
		return ACTION_TYPE.STAND;
	} else {
	    return ACTION_TYPE.ATTACK;
	}
}

function build_action_struct(character, tile, param_ACTION_TYPE_ENUM) {
	return {
		ACTION_TYPE_ID: param_ACTION_TYPE_ENUM,
		INVOKER_CHAR: character,
		DESTINATION_TILE: tile,
		ACTION_COST: function() {
			switch (ACTION_TYPE_ID) {
			    case ACTION_TYPE.STEP:
			        return INVOKER_CHAR.stats.STEP.COST.BASE;
			    case ACTION_TYPE.ATTACK:
			        return 3;
			}
			return 0;
		}
	};
}


function ActionStruct(_type, _invoker, _target_tile, _from_intent) {
	return {
		id: generate_unique_action_id(), // unikalny identyfikator (np. do logowania/debugowania)

		type: _type,                    // enum ACTION_TYPE
		invoker: _invoker,             // obiekt postaci
		target_tile: _target_tile,     // tile do którego celujemy (może mieć character)
		from_intent: _from_intent,     // np. MOVE_LEFT itp.

		parent_action: noone,          // referencja do akcji nadrzędnej (jeśli powstała z eventu)
		origin_action: noone,          // referencja do pierwszej akcji w łańcuchu (dla śledzenia)
		recursion_depth: 0,            // przydatne do zabezpieczenia przed pętlami
	};
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