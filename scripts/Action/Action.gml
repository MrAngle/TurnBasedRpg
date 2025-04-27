// ActionStruct	Definicja co ma się wydarzyć	Atakuj tile[5, 3]
// ActionContextStruct	Jakie są warunki dookoła akcji	Kto jest celem, jakie efekty są aktywne
// ResolvedActionStruct	Kompletna akcja + wykonanie	resolved.apply()

/// @function ActionStruct
/// @desc Tworzy nową strukturę akcji w systemie walki.
///       Akcja definiuje typ działania (atak, ruch, itd.), 
// 		  ActionStruct	Definicja co ma się wydarzyć	Atakuj tile[5, 3]
///       inicjatora, cel oraz dane pomocnicze takie jak głębokość rekurencji.
/// @constructor
///
/// @param {Struct.ENUM_STRUCT} _type - Obiekt reprezentujący typ akcji (np. global.ENUMS.ACTION_TYPE.ATTACK)
/// @param {Id.Instance<Id.Instance.AbstTurnEntity>} _invoker - Obiekt postaci wykonującej akcję.
/// @param {Struct.MyMapTile} _target_tile - Kafelek, na który akcja jest skierowana.
/// @param {ActionIntentId} _from_intent - Intencja, z której wynikła ta akcja.
/// @param {Array<Struct.__EventTypesEnum>} _eventTypesOnTriggerEnums - Intencja, z której wynikła ta akcja.
///
/// @returns {Struct.ActionStruct}
function ActionStruct(_type, _invoker, _target_tile, _from_intent, _eventTypesOnTriggerEnums, _parentAction = noone) constructor {
	// Priv
	__id = helperGenerateUniqueId();
	__type = _type; 		// enum ACTION_TYPE
	__eventTypesOnTriggerEnums = _eventTypesOnTriggerEnums;
	__invokerTuEnObj = _invoker;
	__target_tile = _target_tile;
	__from_intent = _from_intent;
	__parent_action = _parentAction;
	__origin_action = noone;
	__recursion_depth = 0;

	// Getters
	getId = function() { return __id; };
	getType = function() { return __type; };
	getInvokerTuEnObj = function() { return __invokerTuEnObj; };
	getInvokerTuEnStruct = function() { return getTurnEntityStruct(__invokerTuEnObj); };
	getTargetTile = function() { return __target_tile; };
	getTargetTuEnObj = function() { return __target_tile.getTurnEntityObj(); };
	getFromIntent = function() { return __from_intent; };
	getParentAction = function() { return __parent_action; };
	getOriginAction = function() { return __origin_action; };
	getRecursionDepth = function() { return __recursion_depth; };
	getEventTypesToTrigger = function() { return __eventTypesOnTriggerEnums; };
}

/// @param {Id.Instance<Id.Instance.AbstTurnEntity>} turnEntity
/// @param {Enum.ACTION_INTENT_ENUM} intent_id
/// @returns {Struct.ActionStruct}
function resolveActionFromIntent(intent_id, turnEntity) {
	var pos = get_target_position_from_intent(intent_id, turnEntity);
	var row = pos[0];
	var col = pos[1];

	var targetTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(row, col);

	var ACTION_TYPE_ENUM = resolve_skill_type(turnEntity, targetTile);
	var eventTypesOnTrigger = global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(ACTION_TYPE_ENUM);
	return new ActionStruct(ACTION_TYPE_ENUM, turnEntity, targetTile, intent_id, eventTypesOnTrigger)
}



function get_target_position_from_intent(intent_id, character) {
	var row = character.getRow();
	var col = character.getCol();

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
/// @returns {Struct.__ACTION_TYPE_ENUM}
function resolve_skill_type(turnEntity, tile) {
	var target_character = tile.getTurnEntityObj();
	if (helper_object_not_exists(target_character)) {
	    // return ACTION_TYPE_ENUM.STEP;
		return global.ENUMS.ACTION_TYPE.STEP;
	}
	
	if(target_character == turnEntity) {
		// return ACTION_TYPE_ENUM.STAND;
		return global.ENUMS.ACTION_TYPE.STAND;
	} else {
	    // return ACTION_TYPE_ENUM.ATTACK;
		return global.ENUMS.ACTION_TYPE.ATTACK;
	}

}




