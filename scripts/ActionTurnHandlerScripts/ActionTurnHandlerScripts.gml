enum ActionTurnStateEnum {
	CALCULATE_NEXT_TURN_ENTITY,
	
	WAITING_FOR_USER_INPUT, // -> PERFORM ACTION
	PROCESS_AI_INTENT,
	PREPARE_ACTION_INTENT_TO_ACTION,
	PERFORM_ACTION,
}

function onStepTurnProcessor() {
	switch (global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE) {
	    case ActionTurnStateEnum.CALCULATE_NEXT_TURN_ENTITY:
	        // Logika wyboru następnej jednostki do tury
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY = getNextTurnEntity();
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = 
				getNextStateBasedOnSide(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY)
	        break;

		case ActionTurnStateEnum.PROCESS_AI_INTENT:
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ID = 
				autoActionResolveIntent(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY);
		
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnStateEnum.PREPARE_ACTION_INTENT_TO_ACTION;
			break;

		case ActionTurnStateEnum.PREPARE_ACTION_INTENT_TO_ACTION:
			processPrepareActionIntentToAction();
			break;

	    case ActionTurnStateEnum.WAITING_FOR_USER_INPUT:
			waitingForUserInput()
			break;
		
	    case ActionTurnStateEnum.PERFORM_ACTION:
			processCurrentAction(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_STRUCT);
	        break;

	    default:
	        LOG_CRITICAL_MESSAGE("⚠️ Nieznany stan tury: " + string(arg_CurrentTurnState));
	        break;
	}
}

function processPrepareActionIntentToAction() {
	var intent_id = global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ID;
	var character = global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY;

	var action = resolve_action_from_intent(intent_id, character);
	global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_STRUCT = action;

	if (helper_is_not_definied(action)) {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnStateEnum.CALCULATE_NEXT_TURN_ENTITY;
	} else {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnStateEnum.PERFORM_ACTION;
	}
}

function waitingForUserInput() {
	
	if(isLastInputAutoAction()) {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnStateEnum.PROCESS_AI_INTENT;
		return;
	}
	
	global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ID = 
		get_action_intent_from_last_input();
	if(helper_is_definied(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ID)) {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnStateEnum.PREPARE_ACTION_INTENT_TO_ACTION;
	}
}

function getActionToPerform(arg_turnEntity) {
	if(arg_turnEntity.my_character_side == CombatCharacterSideEnum.PLAYER) {
		return ActionTurnStateEnum.WAITING_FOR_USER_INPUT;
	} else {
		return ActionTurnStateEnum.PERFORM_ACTION
	}
}

function getNextStateBasedOnSide(arg_turnEntity) {
	if(arg_turnEntity.my_character_side == CombatCharacterSideEnum.PLAYER) {
		return ActionTurnStateEnum.WAITING_FOR_USER_INPUT;
	} else {
		//global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION_INTENT_ID = ActionIntentId.AUTO_ACTION;
		return ActionTurnStateEnum.PROCESS_AI_INTENT
	}
}

function getNextTurnEntity() {
	return get_turn_entity_with_least_action_points();
}


function get_turn_entity_with_least_action_points() {
    var tiles = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([
        //mapTile_filter_element_contains_player_character()
        mapTile_filter_element_contains_turn_entity()
    ]);

    var lowest_turnEntity = undefined;
    var lowest_ap = 99999999; // duża liczba na start

    for (var i = 0; i < array_length(tiles); i++) {
        var tile = tiles[i];

        if (!tile.has_turn_entity()) continue;

        var turnEntity = tile.get_turn_entity();
        var ap = turnEntity.getActionPoints();

        if (ap < lowest_ap) {
            lowest_ap = ap;
            lowest_turnEntity = turnEntity;
        }
    }

    return lowest_turnEntity;
}

function processCurrentAction(arg_action) {
	var action = arg_action;

	if (helper_is_definied(action)) {
		var character = action.INVOKER_CHAR;
		var tile = action.DESTINATION_TILE;

		// Wykonaj akcję na podstawie typu
		switch (action.ACTION_TYPE_ID) {
			case ACTION_TYPE.STEP:
				performEvent(character, tile.getRow(), tile.getCol());
				break;
			case ACTION_TYPE.ATTACK:
				performEvent(character, tile.getRow(), tile.getCol());
				break;

			case ACTION_TYPE.STAND:
				// np. nie rób nic, albo zakończ turę bez ruchu
				break;
		}

		// Dodaj punkty akcji (tymczasowo, później koszt zależny od typu)
		character.addActionPoints(4); // albo: action.ACTION_COST()

		// Wyczyść po przetworzeniu
		global.INPUT_LAST_TRIGGER = undefined;
		global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = noone;
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnStateEnum.CALCULATE_NEXT_TURN_ENTITY;
	}
}
