enum ActionTurnEnum {
	CALCULATE_NEXT_TURN_ENTITY,
	
	WAITING_FOR_USER_INPUT, // -> PERFORM ACTION
	PREPARE_ACTION,
	PERFORM_ACTION,
}

function onStepTurnProcessor() {
	switch (global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE) {
	    case ActionTurnEnum.CALCULATE_NEXT_TURN_ENTITY:
	        // Logika wyboru następnej jednostki do tury
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY = getNextTurnEntity();
			global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = 
				getNextStateBasedOnSide(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY)
	        break;

	    case ActionTurnEnum.PERFORM_ACTION:
			processCurrentAction();
		
	        // Wykonanie zaplanowanej akcji
	        //perform_current_action();
	        break;
		//case PREPARE_ACTION:
		//	break;

	    case ActionTurnEnum.WAITING_FOR_USER_INPUT:
	        global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION = get_action_from_input(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER);
			if(helper_is_definied(global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION)) {
				global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnEnum.PERFORM_ACTION;
			}
			
			break;

	    default:
	        LOG_CRITICAL_MESSAGE("⚠️ Nieznany stan tury: " + string(arg_CurrentTurnState));
	        break;
	}
}

function getActionToPerform(arg_turnEntity) {
	if(arg_turnEntity.my_character_side == CombatCharacterSideEnum.PLAYER) {
		return ActionTurnEnum.WAITING_FOR_USER_INPUT;
	} else {
		return ActionTurnEnum.PERFORM_ACTION
	}
}



function getNextStateBasedOnSide(arg_turnEntity) {
	if(arg_turnEntity.my_character_side == CombatCharacterSideEnum.PLAYER) {
		return ActionTurnEnum.WAITING_FOR_USER_INPUT;
	} else {
		global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION = variable_struct_get(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.auto_action.name)
		return ActionTurnEnum.PERFORM_ACTION
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


function processCurrentAction() {
	var action_meta = global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ACTION;
	var character = global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_ENTITY;

	if (!is_undefined(action_meta)) {
	    var row_index = character.properties_map_element_row_index;
	    var col_index = character.properties_map_element_col_index;

	    switch (action_meta.type) {
	        case ActionTypeEnum.AUTO_ACTION:
	            var target = get_target_tile_to_nearest_enemy(character, row_index, col_index);
	            performEvent(character, target[0], target[1]);
	            break;

	        case ActionTypeEnum.MOVE:
	            switch (action_meta.action_id) {
	                case ActionIdEnum.MOVE_LEFT:
	                    performEvent(character, row_index, col_index - 1);
	                    break;

	                case ActionIdEnum.MOVE_RIGHT:
	                    performEvent(character, row_index, col_index + 1);
	                    break;

	                case ActionIdEnum.MOVE_UP_LEFT:
	                    performEvent(character, row_index - 1, row_index % 2 == 0 ? col_index - 1 : col_index);
	                    break;

	                case ActionIdEnum.MOVE_UP_RIGHT:
	                    performEvent(character, row_index - 1, row_index % 2 == 0 ? col_index : col_index + 1);
	                    break;

	                case ActionIdEnum.MOVE_DOWN_LEFT:
	                    performEvent(character, row_index + 1, row_index % 2 == 0 ? col_index - 1 : col_index);
	                    break;

	                case ActionIdEnum.MOVE_DOWN_RIGHT:
	                    performEvent(character, row_index + 1, row_index % 2 == 0 ? col_index : col_index + 1);
	                    break;
	            }
	            break;
	    }
	}

	// Wyczyść po przetworzeniu
	character.addActionPoints(4);
	global.INPUT_LAST_TRIGGER = undefined;
	global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = noone;
	global.COMBAT_GLOBALS.ACTION.CURRENT_TURN_STATE = ActionTurnEnum.CALCULATE_NEXT_TURN_ENTITY;
}