enum ACTION_MODE_ENUM {
    APPLY,
    PREDICT
}

// ALL enums should be created in that way 
enum FACTION_ENUM {
	PLAYER,
	ENEMY,
	NEUTRAL
}

enum ACTION_TYPE_ENUM {
	ATTACK,
	STEP,
	STAND
}


enum ACTION_INTENT_ENUM {
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

//global.ENUMS = {};

//// ACTION_TYPE
//ACTION_TYPE = create_enum_struct([
//    "ATTACK",
//    "STEP",
//    "STAND"
//]);

//// ActionIntentId
//global.ENUMS.ACTION_INTENT = create_enum_struct([
//    // "AUTO_ACTION",  // opcjonalnie wyłączone
//    "MOVE_LEFT",
//    "MOVE_RIGHT",
//    "MOVE_UP_LEFT",
//    "MOVE_UP_RIGHT",
//    "MOVE_DOWN_LEFT",
//    "MOVE_DOWN_RIGHT",
//    "STAND",
//    "CONFIRM",
//    "CANCEL",
//    "INTERACT"
//]);

//// CommandEventId
//global.ENUMS.COMMAND_EVENT = create_enum_struct([
//    "AUTO_ACTION",
//    "MOVE_LEFT",
//    "MOVE_RIGHT",
//    "MOVE_UP_LEFT",
//    "MOVE_UP_RIGHT",
//    "MOVE_DOWN_LEFT",
//    "MOVE_DOWN_RIGHT",
//    "CONFIRM",
//    "CANCEL",
//    "INTERACT",
//    "STAND"
//]);

//function create_enum_struct(labels_array) {
//    var enum_struct = {};
//    for (var i = 0; i < array_length(labels_array); i++) {
//        var name = labels_array[i];
//        enum_struct[name] = {
//            eId: i,
//            label: name
//        };
//    }
//    return enum_struct;
//}