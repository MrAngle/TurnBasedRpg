/// @param {Struct.ENUM_STRUCT} _actionTypeEnum - Obiekt reprezentujący typ akcji (np. global.ENUMS.ACTION_TYPE.ATTACK)
/// @returns {Struct.ActionStructBuilder}
function ActionStructBuilder(_actionTypeEnum) constructor {

	/// @type {Struct.ENUM_STRUCT} Represents the type of action (e.g., global.ENUMS.ACTION_TYPE.ATTACK).
	__actionTypeEnum = _actionTypeEnum;
	/// @type {Id.Instance<Id.Instance.AbstTurnEntity>} The entity performing the action.
	__invokerTurnEntityObj = noone;
	/// @type {Struct.MyMapTile} The tile targeted by the action.
	__originMapTile = noone;
	/// @type {Struct.ActionTargetResolverInterface} The intent from which this action originated.
	__actionTargetResolverStruct = noone;
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

	/// @param {Struct.MyMapTile} _originMapTile
	/// @param {Struct.ActionTargetResolverInterface} _actionTargetResolverStruct
	withTargetMapTile = function(_originMapTile, _actionTargetResolverStruct) {
		if(helper_is_definied(_originMapTile) && helper_is_not_definied(_actionTargetResolverStruct)) {
			LOG_CRITICAL_MESSAGE(
				"[ActionStructBuilder] withTargetMapTile: _originMapTile is defined but _actionTargetResolverStruct is not. This is unexpected. TILE STRUCT:" + string(_originMapTile));
		}

		__originMapTile = _originMapTile;
		__actionTargetResolverStruct = _actionTargetResolverStruct;
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

		var actionTargetResolverStruct = helper_is_definied(__actionTargetResolverStruct)
			? __actionTargetResolverStruct
			: new ActionTargetResolver_None();

        return new __ActionStruct(
            __actionTypeEnum,
			__invokerTurnEntityObj,
			__originMapTile,
			__actionIntentId,
			effectiveEventTypes,
			__parentActionStruct,
			actionTargetResolverStruct
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
/// @param {Struct.MyMapTile} _originTargetTile - Kafelek, na który akcja jest skierowana.
/// @param {ActionIntentId} _from_intent - Intencja, z której wynikła ta akcja.
/// @param {Array<Struct.__EventTypesEnum>} _eventTypesOnTriggerEnums - Intencja, z której wynikła ta akcja.
/// @param {Struct.__ActionStruct} _origin_action - Akcja, z której wynikła ta akcja.
/// @param {Struct.ActionTargetResolverInterface} _actionTargetResolverStruct - Interfejs do rozwiązywania celów akcji.
///
/// @returns {Struct.__ActionStruct}
function __ActionStruct(	_type, 
						_invoker_obj, 
						_originTargetTile, 
						_from_intent, 
						_eventTypesOnTriggerEnums,
						_origin_action,
						_actionTargetResolverStruct) constructor {
	// Priv
	__id = helperGenerateUniqueId();

	/// @type {Struct.ENUM_STRUCT} Represents the type of action (e.g., global.ENUMS.ACTION_TYPE.ATTACK).
	__type = _type;
	/// @type {Id.Instance<Id.Instance.AbstTurnEntity>} The entity performing the action.
	__invokerTuEnObj = _invoker_obj;
	/// @type {Struct.MyMapTile} The tile targeted by the action.
	__originTargetTile = _originTargetTile;
	/// @type {Struct.ActionTargetResolverInterface} Interface for resolving action targets.
	__actionTargetResolverStruct = _actionTargetResolverStruct;
	/// @type {ActionIntentId} The intent from which this action originated.
	__from_intent = _from_intent;
	/// @type {Array<Struct.__EventTypesEnum>} Event types triggered by the action.
	__eventTypesOnTriggerEnums = _eventTypesOnTriggerEnums;
	/// @type {Struct.__ActionStruct} The parent action, if any.
	__origin_action = _origin_action;
	/// @type {Struct.__ActionStruct} The parent action, if any.
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
	getOriginTargetTile = function() { return __originTargetTile; };
	getOriginTargetTuEnObj = function() { return __originTargetTile.getTurnEntityObj(); };
	getOriginTargetTuEnStruct = function() { return getTurnEntityStruct(getOriginTargetTuEnObj()); };
	getFromIntent = function() { return __from_intent; };
	getParentAction = function() { return __parent_action; };
	getOriginAction = function() { return __origin_action; };
	getRecursionDepth = function() { return __recursion_depth; };
	getEventTypesToTrigger = function() { return __eventTypesOnTriggerEnums; };

	// LOGIC

	calculateGetTargetTiles = function() {
		if (helper_is_not_definied(__actionTargetResolverStruct)) {
			LOG_CRITICAL_MESSAGE("[ActionStruct] processTargetTiles: __actionTargetResolverStruct is not defined. Returning empty array.");
			return [];
		}
		return __actionTargetResolverStruct.getTargetTiles(self);
	};
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

	return new ActionStructBuilder(ACTION_TYPE_ENUM)
		.withInvokerTurnEntityObj(turnEntity)
		.withTargetMapTile(targetTile, new ActionTargetResolver_OriginTileAsTarget())
		.withActionIntentId(intent_id)
		.withEventTypesEnumArray(global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(ACTION_TYPE_ENUM))
		.build();
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




