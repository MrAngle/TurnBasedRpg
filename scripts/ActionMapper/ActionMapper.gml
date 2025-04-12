enum ActionTypeEnum {
    MOVE,
    AUTO_ACTION
}

enum ActionIdEnum {
    AUTO_ACTION,
    MOVE_LEFT,
    MOVE_RIGHT,
    MOVE_UP_LEFT,
    MOVE_UP_RIGHT,
    MOVE_DOWN_LEFT,
    MOVE_DOWN_RIGHT
}

function init_action_type_map() {
    global.ACTION_TYPE_MAP = {};

    // AUTO_ACTION
    variable_struct_set(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.auto_action.name, {
        action_id: ActionIdEnum.AUTO_ACTION,
        type: ActionTypeEnum.AUTO_ACTION
    });

    // RUCHY
    variable_struct_set(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.move_left.name, {
        action_id: ActionIdEnum.MOVE_LEFT,
        type: ActionTypeEnum.MOVE
    });

    variable_struct_set(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.move_right.name, {
        action_id: ActionIdEnum.MOVE_RIGHT,
        type: ActionTypeEnum.MOVE
    });

    variable_struct_set(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.move_up_left.name, {
        action_id: ActionIdEnum.MOVE_UP_LEFT,
        type: ActionTypeEnum.MOVE
    });

    variable_struct_set(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.move_up_right.name, {
        action_id: ActionIdEnum.MOVE_UP_RIGHT,
        type: ActionTypeEnum.MOVE
    });

    variable_struct_set(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.move_down_left.name, {
        action_id: ActionIdEnum.MOVE_DOWN_LEFT,
        type: ActionTypeEnum.MOVE
    });

    variable_struct_set(global.ACTION_TYPE_MAP, global.INPUT_CONFIG.move_down_right.name, {
        action_id: ActionIdEnum.MOVE_DOWN_RIGHT,
        type: ActionTypeEnum.MOVE
    });
}


function get_action_from_input(input_id) {
    if (!is_string(input_id)) {
        LOG_INFO_MESSAGE("❌ Nieprawidłowy input_id: " + string(input_id));
        return undefined;
    }

    var action = noone;
	
	if (variable_struct_exists(global.ACTION_TYPE_MAP, input_id)) {
		action = variable_struct_get(global.ACTION_TYPE_MAP, input_id);
	}
	
    if (is_undefined(action)) {
        helper_throw_exception("⚠️ Brak akcji przypisanej do input_id: " + string(input_id));
        return undefined;
    }

    return action;
}

