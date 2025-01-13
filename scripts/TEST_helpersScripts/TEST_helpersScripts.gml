function helper_simulate_click_at_position(_x, _y) {
    // Pobranie obiektu w danym punkcie
    var clickable_object = instance_position(_x, _y, all);

    // Jeśli znaleziono obiekt, wykonaj na nim symulację kliknięcia
    if (clickable_object != noone) {
		show_debug_message("Simulate click at (" + string(_x) + ", " + string(_y) + ")");
		with (clickable_object) {
            event_perform(ev_mouse, ev_left_press);
		}

    } else {
        // Jeśli nie znaleziono obiektu, wyświetl komunikat
        show_debug_message("No clickable object at (" + string(_x) + ", " + string(_y) + ")");
    }
}

function helper_simulate_click_at_position_function(_x_arg, _y_arg) {
    // Pobranie obiektu w danym punkcie
	closedFunction = {
		_x: _x_arg,
		_y: _y_arg,
		toReturn: function() {
			helper_simulate_click_at_position(_x, _y);
		}
	}
	
	return closedFunction.toReturn;
}

function helper_simulate_click_at_index(_x_index, _y_index) {
    // Pobranie obiektu w danym punkcie
	
	var tile = global.myCombatMapHolder.get_tile(_x_index, _y_index);
	var _x = tile.__x_position;
	var _y = tile.__y_position;
	
    var clickable_object = instance_position(_x, _y, all);

    // Jeśli znaleziono obiekt, wykonaj na nim symulację kliknięcia
    if (clickable_object != noone) {
		show_debug_message(
		"Simulate click at INDEX (" + string(_x_index) + ", " + string(_y_index) + ")" +
		" Position(" + string(_x) + ", " + string(_y) + ")");

		with (clickable_object) {
            event_perform(ev_mouse, ev_left_press);
		}

    } else {
        // Jeśli nie znaleziono obiektu, wyświetl komunikat
        show_debug_message("No clickable object at (" + string(_x) + ", " + string(_y) + ")");
    }
}


function helper_simulate_click_at_index_function(_x_arg, _y_arg) {
	closedFunction = {
		_x_index: _x_arg,
		_y_index: _y_arg,
		toReturn: function() {
			helper_simulate_click_at_index(_x_index, _y_index);
		}
	}
	return closedFunction.toReturn;
}

function helper_check_condition_function(_x_arg, _y_arg) {
	closedFunction = {
		_x_index: _x_arg,
		_y_index: _y_arg,
		toReturn: function() {
			helper_simulate_click_at_index(_x_index, _y_index);
		}
	}
	return closedFunction.toReturn;
}


function helper_simulate_key_press_escape() {
	
	with (all) {
	    event_perform(ev_keypress, vk_escape)
	}
    //event_perform(ev_keyboard, vk_escape);
}

function helper_simulate_key_press_escape_function() {
	closedFunction = {
		toReturn: helper_simulate_key_press_escape
	}
	return closedFunction.toReturn;
}

function helper_check_if_char_in_tile(arg_x_index, arg_y_index, arg_objType) {
	var closedFunc = {
		_objType: arg_objType,
		_x_index: arg_x_index,
		_y_index: arg_y_index,
		
		toReturn: function() {
			var tile = global.myCombatMapHolder.get_tile(_x_index, _y_index);
			if(tile.__character.object_index == _objType) {
				show_debug_message("object in  INDEX (" + string(_x_index) + ", " + string(_y_index) + ")");
			} else {
				show_debug_message("[FAIL] object is not in  INDEX (" + string(_x_index) + ", " + string(_y_index) + ")");
				global.TEST_PASSED = false
			}
		}
	}
	return closedFunc.toReturn;
}
