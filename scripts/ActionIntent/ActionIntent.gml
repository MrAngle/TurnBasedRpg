// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum ActionIntentId {
    //AUTO_ACTION,       // np. spacja – automatycznie atakuj lub podejdź do wroga

    MOVE_LEFT,
    MOVE_RIGHT,
    MOVE_UP_LEFT,
    MOVE_UP_RIGHT,
    MOVE_DOWN_LEFT,
    MOVE_DOWN_RIGHT,

	STAND,
    // Przyszłościowo – dla menu, dialogów, itp.
    CONFIRM,
    CANCEL,
    INTERACT
}

global.ACTION_INTENT_TO_DIRECTION = {};

variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ActionIntentId.MOVE_LEFT, DirectionId.LEFT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ActionIntentId.MOVE_RIGHT, DirectionId.RIGHT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ActionIntentId.MOVE_UP_LEFT, DirectionId.UP_LEFT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ActionIntentId.MOVE_UP_RIGHT, DirectionId.UP_RIGHT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ActionIntentId.MOVE_DOWN_LEFT, DirectionId.DOWN_LEFT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ActionIntentId.MOVE_DOWN_RIGHT, DirectionId.DOWN_RIGHT);

function get_direction_from_intent(intent_id) {
	if (variable_struct_exists(global.ACTION_INTENT_TO_DIRECTION, intent_id)) {
		return variable_struct_get(global.ACTION_INTENT_TO_DIRECTION, intent_id);
	}

	// Fallback (np. jeśli STAND lub nieobsługiwane intencje)
	return noone;
}

global.COMMAND_TO_INTENT_MAP = {};

//variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.AUTO_ACTION,     ActionIntentId.AUTO_ACTION);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_LEFT,       ActionIntentId.MOVE_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_RIGHT,      ActionIntentId.MOVE_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_UP_LEFT,    ActionIntentId.MOVE_UP_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_UP_RIGHT,   ActionIntentId.MOVE_UP_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_DOWN_LEFT,  ActionIntentId.MOVE_DOWN_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_DOWN_RIGHT, ActionIntentId.MOVE_DOWN_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.STAND, ActionIntentId.STAND);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.CONFIRM,         ActionIntentId.CONFIRM);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.CANCEL,          ActionIntentId.CANCEL);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.INTERACT,        ActionIntentId.INTERACT);

function get_intent_from_direction(arg_Direction) {
	// Odwrotność mapy ACTION_INTENT_TO_DIRECTION
	switch (arg_Direction) {
		case DirectionId.LEFT:        return ActionIntentId.MOVE_LEFT;
		case DirectionId.RIGHT:       return ActionIntentId.MOVE_RIGHT;
		case DirectionId.UP_LEFT:     return ActionIntentId.MOVE_UP_LEFT;
		case DirectionId.UP_RIGHT:    return ActionIntentId.MOVE_UP_RIGHT;
		case DirectionId.DOWN_LEFT:   return ActionIntentId.MOVE_DOWN_LEFT;
		case DirectionId.DOWN_RIGHT:  return ActionIntentId.MOVE_DOWN_RIGHT;
		default:                      return ActionIntentId.STAND;
	}
}

function map_command_to_intent(arg_CommandEventId) {
	var actionIntentId = variable_struct_get(global.COMMAND_TO_INTENT_MAP, arg_CommandEventId);
	if (helper_is_not_definied(actionIntentId)) {
	    helper_throw_exception("Unexpected event id: " + string(arg_CommandEventId));
	}
	return actionIntentId;
}

function isLastInputAutoAction() {
	if(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER == CommandEventId.AUTO_ACTION) {
		return true;
	}
	return false;
}

function get_action_intent_from_last_input() {
    var event_id = global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER;

    if (helper_is_not_definied(event_id)) return undefined;

show_debug_message("TRIGGER: " + string(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER));
show_debug_message("TYPE: " + typeof(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER));
show_debug_message("CommandEventId.AUTO_ACTION: " + string(CommandEventId.AUTO_ACTION));
show_debug_message("TYPE CommandEventId.AUTO_ACTION: " + typeof(CommandEventId.AUTO_ACTION));
show_debug_message("TRIGGER == AUTO_ACTION " + string(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER == CommandEventId.AUTO_ACTION));

    var intent_id = map_command_to_intent(event_id);

    if (helper_is_not_definied(intent_id)) {
        LOG_INFO_MESSAGE("⚠️ Brak mapowania CommandEventId → ActionIntentId dla: " + string(event_id));
        return undefined;
    }
	
	return intent_id;
}