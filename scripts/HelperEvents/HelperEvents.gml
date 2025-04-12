//function helper_check_pressed_once(key) {
//    if (global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME) return false;

//    if (keyboard_check_pressed(key)) {
//        global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME = true;
//        global.LAST_INPUT_KEY = key; // dla logów/debuga
//        return true;
//    }

//    return false;
//}

//function helper_check_pressed_once(action_name) {
//    if (global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME) return false;

//    var keys = global.INPUT_MAP[? action_name];
//    if (!is_array(keys)) return false;

//    for (var i = 0; i < array_length(keys); i++) {
//        var key = keys[i];
//        if (keyboard_check_pressed(key)) {
//            global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME = true;
//            global.LAST_INPUT_KEY = key; // log/debug
//            return true;
//        }
//    }

//    return false;
//}


function input_check_pressed_once(action_id) {
    if (global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME) return false;

    if (!is_string(action_id)) {
        show_debug_message("❌ BŁĄD: action_id nie jest stringiem: " + string(action_id));
        return false;
    }

    if (!variable_struct_exists(global.INPUT_CONFIG, action_id)) {
        show_debug_message("❌ BŁĄD: INPUT_CONFIG nie zawiera: " + string(action_id));
        return false;
    }

	var action = variable_struct_get(global.INPUT_CONFIG, action_id);

    if (!is_struct(action) || !is_array(action.keys)) {
        show_debug_message("❌ BŁĄD: Nieprawidłowa struktura akcji: " + string(action_id));
        return false;
    }

    for (var i = 0; i < array_length(action.keys); i++) {
        if (keyboard_check_pressed(action.keys[i])) {
            global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME = true;
            global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = action.name;
            return true;
        }
    }

    return false;
}
