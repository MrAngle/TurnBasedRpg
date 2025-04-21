global.ENUM_LABELS = {}


/// @function ENUM_STRUCT
/// @description Creates a structure representing a single enum-like value with both ID and label.
/// @constructor
///
/// @param {Real} _id - Numeric identifier of the enum value (e.g. 100, 101...).
/// @param {String} _label - String label of the enum value (e.g. "STEP", "ATTACK").
///
/// @returns {Struct.ENUM_STRUCT}
function ENUM_STRUCT(_id, _label) constructor {
    /// Numeric ID of the enum value
    id = _id;

    /// Readable label of the enum value
    label = _label;
}


enum ACTION_MODE_ENUM {
    APPLY,
    PREDICT
}

enum FACTION_ENUM {
	PLAYER,
	ENEMY,
	NEUTRAL
}

// Connected with ENUM LABELS
// enum ACTION_TYPE_ENUM {
// 	ATTACK = 100,
// 	STEP = 101,
// 	STAND = 102
// }

function ActionTypeEnumStruct() constructor {
    
    // ATTACK  = { id: 100, label: "ATTACK" };
    // STEP    =   { id: 101, label: "STEP" };
    // STAND   =  { id: 102, label: "STAND" };

    ATTACK  = new ENUM_STRUCT(100, "ATTACK");
    STEP  = new ENUM_STRUCT(101, "STEP");
    STAND  = new ENUM_STRUCT(102, "STAND");
};

// global.ENUMS.ACTION_TYPE = new ActionTypeEnumStruct();

// global.ENUMS.ACTION_TYPE.



// global.ENUM_LABELS.ACTION_TYPE = {};
// variable_struct_set(global.ENUM_LABELS.ACTION_TYPE, ACTION_TYPE_ENUM.ATTACK, "ATTACK");
// variable_struct_set(global.ENUM_LABELS.ACTION_TYPE, ACTION_TYPE_ENUM.STEP,   "STEP");
// variable_struct_set(global.ENUM_LABELS.ACTION_TYPE, ACTION_TYPE_ENUM.STAND,  "STAND");



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