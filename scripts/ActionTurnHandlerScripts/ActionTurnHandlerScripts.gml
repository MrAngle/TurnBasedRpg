enum ACTION_TURN_STATE_ENUM {
	CALCULATE_NEXT_TURN_ENTITY,
	
	WAITING_FOR_USER_INPUT, // -> PERFORM ACTION
	PROCESS_AI_INTENT,
	PREPARE_ACTION_RESOLVE,
	PERFORM_ACTION,
}

function onStepTurnProcessor() {
	switch (global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM) {
	    case ACTION_TURN_STATE_ENUM.CALCULATE_NEXT_TURN_ENTITY:
	        // Logika wyboru następnej jednostki do tury
			global.COMBAT_GLOBALS.ACTION.CURRENT_INVOKER_TURN_ENTITY_OBJ = getNextTurnEntity();
			global.COMBAT_GLOBALS.ACTION.CURRENT_MIN_ACTION_POINTS = getTurnEntityStruct(global.COMBAT_GLOBALS.ACTION.CURRENT_INVOKER_TURN_ENTITY_OBJ).getActionPoints();
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = 
				getNextStateBasedOnSideForObj(global.COMBAT_GLOBALS.ACTION.CURRENT_INVOKER_TURN_ENTITY_OBJ)
	        break;

		case ACTION_TURN_STATE_ENUM.PROCESS_AI_INTENT:
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ENUM = 
				autoActionResolveIntent(global.COMBAT_GLOBALS.ACTION.CURRENT_INVOKER_TURN_ENTITY_OBJ);
		
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.PREPARE_ACTION_RESOLVE;
			break;

		case ACTION_TURN_STATE_ENUM.WAITING_FOR_USER_INPUT:
			waitingForUserInput()
			break;

		case ACTION_TURN_STATE_ENUM.PREPARE_ACTION_RESOLVE:
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_RESOLVED_STRUCT = 
				processPrepareActionResolvedStruct();
			processNextStepAfterActionResolvedPreparation()
			break;
		
	    case ACTION_TURN_STATE_ENUM.PERFORM_ACTION:
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_RESOLVED_STRUCT.execute();

			// remove?
			global.INPUT_LAST_TRIGGER = undefined;
			global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = noone;
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.CALCULATE_NEXT_TURN_ENTITY;
	        break;

	    default:
	        LOG_CRITICAL_MESSAGE("⚠️ Nieznany stan tury: " + string(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM));
	        break;
	}
}

function processPrepareActionIntentToAction() {
	var intent_id = global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ENUM;
	var character = global.COMBAT_GLOBALS.ACTION.CURRENT_INVOKER_TURN_ENTITY_OBJ;

	var action = resolveActionFromIntent(intent_id, character);
	return action;
}

/// @returns {Struct.__ActionResolvedStruct}
function processPrepareActionResolvedStruct() {
	var actionStruct = processPrepareActionIntentToAction();
	var actionContext = new ActionContextStruct(actionStruct);
	var actionResolved = ActionResolvedStructBuilder(actionContext);
	return actionResolved;
}

function processNextStepAfterActionResolvedPreparation() {
	if (helper_is_not_definied(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_RESOLVED_STRUCT)) {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.CALCULATE_NEXT_TURN_ENTITY;
	} else {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.PERFORM_ACTION;
	}
}

function waitingForUserInput() {
	
	if(isLastInputAutoAction()) {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.PROCESS_AI_INTENT;
		return;
	}
	
	global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ENUM = 
		get_action_intent_from_last_input();
	if(helper_is_definied(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ENUM)) {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.PREPARE_ACTION_RESOLVE;
	}
}

/// @param {Id.Instance<Id.Instance.AbstTurnEntity>} arg_objTurnEntity
function getNextStateBasedOnSideForObj(arg_objTurnEntity) {
	return getNextStateBasedOnSide(getTurnEntityStruct(arg_objTurnEntity));
}

/// @param {Struct.TurnEntityStruct} arg_turnEntity 
/// @returns {Enum.ACTION_TURN_STATE_ENUM}
function getNextStateBasedOnSide(arg_turnEntity) {
	if(arg_turnEntity.getFaction() == FACTION_ENUM.PLAYER) {
		return ACTION_TURN_STATE_ENUM.WAITING_FOR_USER_INPUT;
	} else {
		//global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ID = ActionIntentId.AUTO_ACTION;
		return ACTION_TURN_STATE_ENUM.PROCESS_AI_INTENT
	}
}

/// @returns {Id.Instance.AbstTurnEntity}
function getNextTurnEntity() {
	return get_turn_entity_with_least_action_points();
}

/// @returns {Id.Instance.AbstTurnEntity}
function get_turn_entity_with_least_action_points() {
    var tiles = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([
        //mapTile_filter_element_contains_player_character()
        mapTile_filter_element_contains_turn_entity()
    ]);

    var lowest_turnEntity = undefined;
    var lowest_ap = 99999999; // duża liczba na start

    for (var i = 0; i < array_length(tiles); i++) {
		/// @type {Struct.MyMapTile}
        var tile = tiles[i];

        if (!tile.hasTurnEntity()) continue;

		var turnEntityObj = tile.getTurnEntityObj();
        var turnEntity = getTurnEntityStruct(turnEntityObj);

        var ap = turnEntity.getActionPoints();

        if (ap < lowest_ap) {
            lowest_ap = ap;
            lowest_turnEntity = turnEntityObj;
        }
    }

    return lowest_turnEntity;
}
