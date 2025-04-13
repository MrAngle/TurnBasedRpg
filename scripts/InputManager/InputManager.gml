// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
// Mapa: akcje → lista klawiszy
//global.INPUT_CONFIG = {
//    ACTION_NAME: {
//        auto_action: "auto_action",
//        move_left: "move_left",
//        move_right: "move_right",
//        move_up_left: "move_up_left",
//        move_up_right: "move_up_right",
//        move_down_left: "move_down_left",
//        move_down_right: "move_down_right"
//    },

//    MAP: {
//        auto_action: [vk_space],
//        move_left: [vk_numpad4],
//        move_right: [vk_numpad6],
//        move_up_left: [vk_numpad7],
//        move_up_right: [vk_numpad9],
//        move_down_left: [vk_numpad1],
//        move_down_right: [vk_numpad3]
//    }
//};

//enum ActionTypeEnum {
//    MOVE,
//    AUTO_ACTION
//}

//global.EVENT_NAME = {
//    AUTO_ACTION:     "auto_action",
//    MOVE_LEFT:       "move_left",
//    MOVE_RIGHT:      "move_right",
//    MOVE_UP_LEFT:    "move_up_left",
//    MOVE_UP_RIGHT:   "move_up_right",
//    MOVE_DOWN_LEFT:  "move_down_left",
//    MOVE_DOWN_RIGHT: "move_down_right"
//};


//global.INPUT_CONFIG = {
//    auto_action: {
//        name: global.EVENT_NAME.AUTO_ACTION,
//        keys: [vk_space]
//    },
//    move_left: {
//        name: global.EVENT_NAME.MOVE_LEFT,
//        keys: [vk_numpad4]
//    },
//    move_right: {
//        name: global.EVENT_NAME.MOVE_RIGHT,
//        keys: [vk_numpad6]
//    },
//    move_up_left: {
//        name: global.EVENT_NAME.MOVE_UP_LEFT,
//        keys: [vk_numpad7]
//    },
//    move_up_right: {
//        name: global.EVENT_NAME.MOVE_UP_RIGHT,
//        keys: [vk_numpad9]
//    },
//    move_down_left: {
//        name: global.EVENT_NAME.MOVE_DOWN_LEFT,
//        keys: [vk_numpad1]
//    },
//    move_down_right: {
//        name: global.EVENT_NAME.MOVE_DOWN_RIGHT,
//        keys: [vk_numpad3]
//    }
//};


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


