if (global.COMBAT_GLOBALS.ACTION.PROCESSING) {
    exit;
}

process_input_once();

//var row_index = character.properties_map_element_row_index;
//var col_index = character.properties_map_element_col_index;

// AUTO_ACTION (spacja + repeat)
//var auto_action_name = global.INPUT_CONFIG.auto_action.name;

//if (input_check_pressed_once(auto_action_name)) {
//    //var target = get_target_tile_to_nearest_enemy(row_index, col_index);
//    //performEvent(character, target[0], target[1]);
//    repeat_timer = 0;
//}
//else {
//    var keys = global.INPUT_CONFIG.auto_action.keys;
//    var key_held = false;

//    for (var i = 0; i < array_length(keys); i++) {
//        if (keyboard_check(keys[i])) {
//            key_held = true;
//            break;
//        }
//    }

//    if (key_held) {
//        repeat_timer++;

//        if (repeat_timer > repeat_delay && repeat_timer mod repeat_interval == 0) {
//            //var target = get_target_tile_to_nearest_enemy(row_index, col_index);
//            //performEvent(character, target[0], target[1]);
//            //global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME = true;
//        }
//    } else {
//        repeat_timer = 0;
//    }
//}

//// POZOSTAŁE KIERUNKI

//if (input_check_pressed_once(global.INPUT_CONFIG.move_down_left.name)) {
//    //performEvent(character, row_index + 1, row_index % 2 == 0 ? col_index - 1 : col_index);
//}

//if (input_check_pressed_once(global.INPUT_CONFIG.move_down_right.name)) {
//    //performEvent(character, row_index + 1, row_index % 2 == 0 ? col_index : col_index + 1);
//}

//if (input_check_pressed_once(global.INPUT_CONFIG.move_left.name)) {
//    //performEvent(character, row_index, col_index - 1);
//}

//if (input_check_pressed_once(global.INPUT_CONFIG.move_right.name)) {
//    //performEvent(character, row_index, col_index + 1);
//}

//if (input_check_pressed_once(global.INPUT_CONFIG.move_up_left.name)) {
//    //performEvent(character, row_index - 1, row_index % 2 == 0 ? col_index - 1 : col_index);
//}

//if (input_check_pressed_once(global.INPUT_CONFIG.move_up_right.name)) {
//    //performEvent(character, row_index - 1, row_index % 2 == 0 ? col_index : col_index + 1);
//}