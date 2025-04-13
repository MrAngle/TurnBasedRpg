// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum ActionIntentId {
    AUTO_ACTION,       // np. spacja – automatycznie atakuj lub podejdź do wroga

    MOVE_LEFT,
    MOVE_RIGHT,
    MOVE_UP_LEFT,
    MOVE_UP_RIGHT,
    MOVE_DOWN_LEFT,
    MOVE_DOWN_RIGHT,

    // Przyszłościowo – dla menu, dialogów, itp.
    CONFIRM,
    CANCEL,
    INTERACT
}

//global.COMMAND_TO_INTENT_MAP = {};

//global.COMMAND_TO_INTENT_MAP[CommandEventId.AUTO_ACTION]     = ActionIntentId.AUTO_ACTION;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.MOVE_LEFT]       = ActionIntentId.MOVE_LEFT;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.MOVE_RIGHT]      = ActionIntentId.MOVE_RIGHT;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.MOVE_UP_LEFT]    = ActionIntentId.MOVE_UP_LEFT;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.MOVE_UP_RIGHT]   = ActionIntentId.MOVE_UP_RIGHT;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.MOVE_DOWN_LEFT]  = ActionIntentId.MOVE_DOWN_LEFT;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.MOVE_DOWN_RIGHT] = ActionIntentId.MOVE_DOWN_RIGHT;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.CONFIRM]         = ActionIntentId.CONFIRM;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.CANCEL]          = ActionIntentId.CANCEL;
//global.COMMAND_TO_INTENT_MAP[CommandEventId.INTERACT]        = ActionIntentId.INTERACT;


global.COMMAND_TO_INTENT_MAP = {}; // upewnij się, że to struct

variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.AUTO_ACTION,     ActionIntentId.AUTO_ACTION);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_LEFT,       ActionIntentId.MOVE_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_RIGHT,      ActionIntentId.MOVE_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_UP_LEFT,    ActionIntentId.MOVE_UP_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_UP_RIGHT,   ActionIntentId.MOVE_UP_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_DOWN_LEFT,  ActionIntentId.MOVE_DOWN_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_DOWN_RIGHT, ActionIntentId.MOVE_DOWN_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.CONFIRM,         ActionIntentId.CONFIRM);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.CANCEL,          ActionIntentId.CANCEL);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.INTERACT,        ActionIntentId.INTERACT);


function map_command_to_intent(arg_CommandEventId) {
	var actionIntentId = variable_struct_get(global.COMMAND_TO_INTENT_MAP, arg_CommandEventId);
	if (helper_is_not_definied(actionIntentId)) {
	    helper_throw_exception("Unexpected event id: " + string(arg_CommandEventId));
	}
	return actionIntentId;
}