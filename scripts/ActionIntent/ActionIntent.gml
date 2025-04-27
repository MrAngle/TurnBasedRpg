


function isLastInputAutoAction() {
	if(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER == CommandEventId.AUTO_ACTION) {
		return true;
	}
	return false;
}

/// @returns {Enum.ACTION_INTENT_ENUM}
function get_action_intent_from_last_input() {
    var event_id = global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER;

    if (helper_is_not_definied(event_id)) return undefined;

// show_debug_message("TRIGGER: " + string(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER));
// show_debug_message("TYPE: " + typeof(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER));
// show_debug_message("CommandEventId.AUTO_ACTION: " + string(CommandEventId.AUTO_ACTION));
// show_debug_message("TYPE CommandEventId.AUTO_ACTION: " + typeof(CommandEventId.AUTO_ACTION));
// show_debug_message("TRIGGER == AUTO_ACTION " + string(global.COMBAT_GLOBALS.EVENT.CLICK.INPUT_LAST_TRIGGER == CommandEventId.AUTO_ACTION));

    var intent_id = global.ENUM_MAPPERS.commandEventIdToActionIntentId(event_id);

    if (helper_is_not_definied(intent_id)) {
        LOG_INFO_MESSAGE("⚠️ Brak mapowania CommandEventId → ActionIntentId dla: " + string(event_id));
        return undefined;
    }
	
	return intent_id;
}