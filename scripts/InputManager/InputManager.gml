enum CommandEventId {
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
    INTERACT,
	
	STAND
}


global.INPUT_CONFIG = {
    combat: {
        auto_action: {
            event_id: CommandEventId.AUTO_ACTION,
            keys: [vk_space]
        },
        move_left: {
            event_id: CommandEventId.MOVE_LEFT,
            keys: [vk_numpad4]
        },
        move_right: {
            event_id: CommandEventId.MOVE_RIGHT,
            keys: [vk_numpad6]
        },
        move_up_left: {
            event_id: CommandEventId.MOVE_UP_LEFT,
            keys: [vk_numpad7]
        },
        move_up_right: {
            event_id: CommandEventId.MOVE_UP_RIGHT,
            keys: [vk_numpad9]
        },
        move_down_left: {
            event_id: CommandEventId.MOVE_DOWN_LEFT,
            keys: [vk_numpad1]
        },
        move_down_right: {
            event_id: CommandEventId.MOVE_DOWN_RIGHT,
            keys: [vk_numpad3]
        },
		
		stand: {
            event_id: CommandEventId.STAND,
            keys: [vk_numpad5]
        },
    }
};


