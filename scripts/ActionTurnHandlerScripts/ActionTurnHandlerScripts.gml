enum ACTION_TURN_STATE_ENUM {
	CALCULATE_NEXT_TURN_ENTITY,
	
	WAITING_FOR_USER_INPUT, // -> PERFORM ACTION
	PROCESS_AI_INTENT,
	PREPARE_ACTION_INTENT_TO_ACTION,
	PERFORM_ACTION,
}

function onStepTurnProcessor() {
	switch (global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM) {
	    case ACTION_TURN_STATE_ENUM.CALCULATE_NEXT_TURN_ENTITY:
	        // Logika wyboru następnej jednostki do tury
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY_OBJ = getNextTurnEntity();
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = 
				getNextStateBasedOnSideForObj(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY_OBJ)
	        break;

		case ACTION_TURN_STATE_ENUM.PROCESS_AI_INTENT:
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ENUM = 
				autoActionResolveIntent(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY_OBJ);
		
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.PREPARE_ACTION_INTENT_TO_ACTION;
			break;

		case ACTION_TURN_STATE_ENUM.PREPARE_ACTION_INTENT_TO_ACTION:
			processPrepareActionIntentToAction();
			break;

	    case ACTION_TURN_STATE_ENUM.WAITING_FOR_USER_INPUT:
			waitingForUserInput()
			break;
		
	    case ACTION_TURN_STATE_ENUM.PERFORM_ACTION:
			processCurrentAction(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_STRUCT);
	        break;

	    default:
	        LOG_CRITICAL_MESSAGE("⚠️ Nieznany stan tury: " + string(arg_CurrentTurnState));
	        break;
	}
}

function processPrepareActionIntentToAction() {
	var intent_id = global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ENUM;
	var character = global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY_OBJ;

	var action = resolveActionFromIntent(intent_id, character);
	global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_STRUCT = action;

	if (helper_is_not_definied(action)) {
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
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.PREPARE_ACTION_INTENT_TO_ACTION;
	}
}

// function getActionToPerform(arg_turnEntity) {
// 	if(arg_turnEntity.my_character_side == CombatCharacterSideEnum.PLAYER) {
// 		return ActionTurnStateEnum.WAITING_FOR_USER_INPUT;
// 	} else {
// 		return ActionTurnStateEnum.PERFORM_ACTION
// 	}
// }

/// @param {Id.Instance<Id.Instance.AbstTurnEntity>} arg_objTurnEntity

function getNextStateBasedOnSideForObj(arg_objTurnEntity) {
	return getNextStateBasedOnSide(getTurnEntityAttributes(arg_objTurnEntity));
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

        if (!tile.has_turn_entity()) continue;

		var turnEntityObj = tile.getTurnEntityObj();
        var turnEntity = getTurnEntityAttributes(turnEntityObj);

        var ap = turnEntity.getActionPoints();

        if (ap < lowest_ap) {
            lowest_ap = ap;
            lowest_turnEntity = turnEntityObj;
        }
    }

    return lowest_turnEntity;
}

/// @param {Struct.ActionStruct} arg_action 
function processCurrentAction(arg_action) {
	var action = arg_action;

	if (helper_is_definied(action)) {
		var character = action.getInvokerTuEnObj();
		var tile = action.getTargetTile();

		// Wykonaj akcję na podstawie typu
		switch (action.getType()) {
			case ACTION_TYPE_ENUM.STEP:
				performEvent(character, tile.getRow(), tile.getCol());
				break;
			case ACTION_TYPE_ENUM.ATTACK:
				performEvent(character, tile.getRow(), tile.getCol());
				break;

			case ACTION_TYPE_ENUM.STAND:
				// np. nie rób nic, albo zakończ turę bez ruchu
				break;
		}

		// Dodaj punkty akcji (tymczasowo, później koszt zależny od typu)
		getTurnEntityAttributes(character).addActionPoints(4); // albo: action.ACTION_COST()

		// Wyczyść po przetworzeniu
		global.INPUT_LAST_TRIGGER = undefined;
		global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = noone;
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE_ENUM = ACTION_TURN_STATE_ENUM.CALCULATE_NEXT_TURN_ENTITY;
	}
}
