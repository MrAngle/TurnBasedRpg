//if (!helper_is_definied(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER) ) {
//    exit;
//}

//var action = global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER;
//var character = getNextTurnEntity();

//if (is_string(action)) {
//    var row_index = character.properties_map_element_row_index;
//    var col_index = character.properties_map_element_col_index;

//    switch (action) {
//        case global.INPUT_CONFIG.auto_action.name:
//            var target = get_target_tile_to_nearest_enemy(row_index, col_index);
//            performEvent(character, target[0], target[1]);
//            break;

//        case global.INPUT_CONFIG.move_down_left.name:
//            performEvent(character, row_index + 1, row_index % 2 == 0 ? col_index - 1 : col_index);
//            break;

//        case global.INPUT_CONFIG.move_down_right.name:
//            performEvent(character, row_index + 1, row_index % 2 == 0 ? col_index : col_index + 1);
//            break;

//        case global.INPUT_CONFIG.move_left.name:
//            performEvent(character, row_index, col_index - 1);
//            break;

//        case global.INPUT_CONFIG.move_right.name:
//            performEvent(character, row_index, col_index + 1);
//            break;

//        case global.INPUT_CONFIG.move_up_left.name:
//            performEvent(character, row_index - 1, row_index % 2 == 0 ? col_index - 1 : col_index);
//            break;

//        case global.INPUT_CONFIG.move_up_right.name:
//            performEvent(character, row_index - 1, row_index % 2 == 0 ? col_index : col_index + 1);
//            break;
//    }

//    // Po przetworzeniu wyczyść
//    global.INPUT_LAST_TRIGGER = undefined;
//	global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = noone;
//}


onStepTurnProcessor();