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


//function input_check_pressed_once(action_id) {
//    if (global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME) return false;

//    if (!is_string(action_id)) {
//        show_debug_message("❌ BŁĄD: action_id nie jest stringiem: " + string(action_id));
//        return false;
//    }

//    if (!variable_struct_exists(global.INPUT_CONFIG, action_id)) {
//        show_debug_message("❌ BŁĄD: INPUT_CONFIG nie zawiera: " + string(action_id));
//        return false;
//    }

//	var action = variable_struct_get(global.INPUT_CONFIG, action_id);

//    if (!is_struct(action) || !is_array(action.keys)) {
//        show_debug_message("❌ BŁĄD: Nieprawidłowa struktura akcji: " + string(action_id));
//        return false;
//    }

//    for (var i = 0; i < array_length(action.keys); i++) {
//        if (keyboard_check_pressed(action.keys[i])) {
//            global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME = true;
//            global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = action.name;
//            return true;
//        }
//    }

//    return false;
//}


function process_input_once() {
    if (global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME) return;

    var context = "combat"; // albo: global.INPUT_CONTEXT
    var context_config = variable_struct_get(global.INPUT_CONFIG, context);

    if (is_undefined(context_config)) return;

    var entries = variable_struct_get_names(context_config);

    for (var i = 0; i < array_length(entries); i++) {
        var input_entry = variable_struct_get(context_config, entries[i]); //context_config[? entries[i]];

        if (!is_struct(input_entry) || !is_array(input_entry.keys)) continue;

        for (var k = 0; k < array_length(input_entry.keys); k++) {
            if (keyboard_check_pressed(input_entry.keys[k])) {
                global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER = input_entry.event_id;
                global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LOCKED_THIS_FRAME = true;
                return; // tylko jeden trigger na klatkę
            }
        }
    }
}