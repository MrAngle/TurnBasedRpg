/// @param {Struct.ENUM_STRUCT} _actionTypeEnum - Obiekt reprezentujący typ akcji (np. global.ENUMS.ACTION_TYPE.ATTACK)
/// @returns {Struct.ActionStructBuilder}
function ActionStructBuilder(_actionTypeEnum) constructor {

	/// @type {Struct.ENUM_STRUCT} Represents the type of action (e.g., global.ENUMS.ACTION_TYPE.ATTACK).
	__actionTypeEnum = _actionTypeEnum;
	/// @type {Id.Instance<Id.Instance.AbstTurnEntity>} The entity performing the action.
	__invokerTurnEntityObj = noone;
	/// @type {Struct.MyMapTile} The tile targeted by the action.
	__targetMapTile = noone;
	/// @type {ActionIntentId} The intent from which this action originated.
	__actionIntentId = false;
	/// @type {Array<Struct.__EventTypesEnum>} Event types triggered by the action.
	__eventTypesEnumArray = undefined;
	/// @type {Struct.__ActionStruct} The parent action, if any.
	__parentActionStruct = noone;

	withInvokerTurnEntityObj = function(_invoker) {
		__invokerTurnEntityObj = _invoker;
		return self;
	};

	withTargetMapTile = function(_tile) {
		__targetMapTile = _tile;
		return self;
	};

	withActionIntentId = function(_intentId) {
		__actionIntentId = _intentId;
		return self;
	};

	withEventTypesEnumArray = function(_types) {
		__eventTypesEnumArray = _types;
		return self;
	};

	withParentActionStruct = function(_parent) {
		__parentActionStruct = _parent;
		return self;
	};

    build = function() {
        var effectiveEventTypes = helper_is_definied(__eventTypesEnumArray)
            ? __eventTypesEnumArray
            : global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(__actionTypeEnum);

        return new __ActionStruct(
            __actionTypeEnum,
			__invokerTurnEntityObj,
			__targetMapTile,
			__actionIntentId,
			effectiveEventTypes,
			__parentActionStruct
        );
    };
}

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
/// @returns {Struct.__ActionStruct}
function __ActionStruct(	_type, 
						_invoker_obj, 
						_target_tile, 
						_from_intent, 
						_eventTypesOnTriggerEnums,
						_origin_action) constructor {
	// Priv
	__id = helperGenerateUniqueId();

	__type = _type;
	__invokerTuEnObj = _invoker_obj;
	__target_tile = _target_tile;
	__from_intent = _from_intent;
	__eventTypesOnTriggerEnums = _eventTypesOnTriggerEnums;
	__origin_action = _origin_action;
	__parent_action = noone;

	// __type = _ActionStruct_ParamFactory.getType();
	// __invokerTuEnObj = _ActionStruct_ParamFactory.getInvokerObj();
	// __target_tile = _ActionStruct_ParamFactory.getTargetTile();
	// __from_intent = _ActionStruct_ParamFactory.getFromIntent();
	// __parent_action = _ActionStruct_ParamFactory.getParentAction();
	// __eventTypesOnTriggerEnums = _ActionStruct_ParamFactory.getEventTypesOnTrigger();

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
/// @returns {Struct.__ActionStruct}
function resolveActionFromIntent(intent_id, turnEntity) {
	var pos = get_target_position_from_intent(intent_id, turnEntity);
	var row = pos[0];
	var col = pos[1];

	var targetTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(row, col);

	var ACTION_TYPE_ENUM = resolve_skill_type(turnEntity, targetTile);

	// var asParams = new ActionStruct_ParamFactory(
	// 	ACTION_TYPE_ENUM, 
	// 	turnEntity, 
	// 	targetTile, 
	// 	intent_id, 
	// 	eventTypesOnTrigger
	// )
	return new ActionStructBuilder(ACTION_TYPE_ENUM)
		.withInvokerTurnEntityObj(turnEntity)
		.withTargetMapTile(targetTile)
		.withActionIntentId(intent_id)
		.withEventTypesEnumArray(global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(ACTION_TYPE_ENUM))
		.build()
	// return new ActionStruct(asParams)
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




