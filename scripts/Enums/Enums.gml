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

function __ACTION_TYPE_ENUM() constructor {
    ATTACK  = new ENUM_STRUCT(100, "ATTACK");
    STEP  = new ENUM_STRUCT(101, "STEP");
    STAND  = new ENUM_STRUCT(102, "STAND");
};

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
