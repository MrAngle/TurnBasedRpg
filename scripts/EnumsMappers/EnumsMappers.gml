// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
global.ENUM_MAPPERS = {
	directionIdToActionIntentId: get_direction_from_intent,
	actionIntentIdToDirectionId: get_intent_from_direction,
	commandEventIdToActionIntentId: map_command_to_intent
}

global.ACTION_INTENT_TO_DIRECTION = {};

variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ACTION_INTENT_ENUM.MOVE_LEFT, DirectionId.LEFT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ACTION_INTENT_ENUM.MOVE_RIGHT, DirectionId.RIGHT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ACTION_INTENT_ENUM.MOVE_UP_LEFT, DirectionId.UP_LEFT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ACTION_INTENT_ENUM.MOVE_UP_RIGHT, DirectionId.UP_RIGHT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ACTION_INTENT_ENUM.MOVE_DOWN_LEFT, DirectionId.DOWN_LEFT);
variable_struct_set(global.ACTION_INTENT_TO_DIRECTION, ACTION_INTENT_ENUM.MOVE_DOWN_RIGHT, DirectionId.DOWN_RIGHT);

function get_direction_from_intent(intent_id) {
	if (variable_struct_exists(global.ACTION_INTENT_TO_DIRECTION, intent_id)) {
		return variable_struct_get(global.ACTION_INTENT_TO_DIRECTION, intent_id);
	}

	// Fallback (np. jeśli STAND lub nieobsługiwane intencje)
	return noone;
}

global.COMMAND_TO_INTENT_MAP = {};

//variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.AUTO_ACTION,     ActionIntentId.AUTO_ACTION);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_LEFT,       ACTION_INTENT_ENUM.MOVE_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_RIGHT,      ACTION_INTENT_ENUM.MOVE_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_UP_LEFT,    ACTION_INTENT_ENUM.MOVE_UP_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_UP_RIGHT,   ACTION_INTENT_ENUM.MOVE_UP_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_DOWN_LEFT,  ACTION_INTENT_ENUM.MOVE_DOWN_LEFT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.MOVE_DOWN_RIGHT, ACTION_INTENT_ENUM.MOVE_DOWN_RIGHT);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.STAND, ACTION_INTENT_ENUM.STAND);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.CONFIRM,         ACTION_INTENT_ENUM.CONFIRM);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.CANCEL,          ACTION_INTENT_ENUM.CANCEL);
variable_struct_set(global.COMMAND_TO_INTENT_MAP, CommandEventId.INTERACT,        ACTION_INTENT_ENUM.INTERACT);

/// @function get_intent_from_direction(arg_Direction)
/// @desc
/// @arg arg_Direction
function get_intent_from_direction(arg_Direction) {
	// Odwrotność mapy ACTION_INTENT_TO_DIRECTION
	switch (arg_Direction) {
		case DirectionId.LEFT:        return ACTION_INTENT_ENUM.MOVE_LEFT;
		case DirectionId.RIGHT:       return ACTION_INTENT_ENUM.MOVE_RIGHT;
		case DirectionId.UP_LEFT:     return ACTION_INTENT_ENUM.MOVE_UP_LEFT;
		case DirectionId.UP_RIGHT:    return ACTION_INTENT_ENUM.MOVE_UP_RIGHT;
		case DirectionId.DOWN_LEFT:   return ACTION_INTENT_ENUM.MOVE_DOWN_LEFT;
		case DirectionId.DOWN_RIGHT:  return ACTION_INTENT_ENUM.MOVE_DOWN_RIGHT;
		default:                      return ACTION_INTENT_ENUM.STAND;
	}
}

/// @returns {Enum.ACTION_INTENT_ENUM}
function map_command_to_intent(arg_CommandEventId) {
	var actionIntentId = variable_struct_get(global.COMMAND_TO_INTENT_MAP, arg_CommandEventId);
	if (helper_is_not_definied(actionIntentId)) {
	    helper_throw_exception("Unexpected event id: " + string(arg_CommandEventId));
	}
	return actionIntentId;
}
