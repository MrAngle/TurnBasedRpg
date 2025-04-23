

global.EVENT_SUBTYPES_ENUM_ENUM = new __EventSubtypesEnumStruct();
/// @returns {Struct.__EventSubtypesEnumStruct}
function __EventSubtypesEnumStruct() constructor {
    ON_STEP         = new ENUM_STRUCT(100, "ON_STEP");
    ON_ENEMY_STEP   = new ENUM_STRUCT(101, "ON_ENEMY_STEP");
    ON_TELEPORT     = new ENUM_STRUCT(102, "ON_TELEPORT");


    ON_ATTACK       = new ENUM_STRUCT(200, "ON_ATTACK");
    ON_HEAL         = new ENUM_STRUCT(201, "ON_HEAL");
}


global.EVENT_FAMILIES = new __EventFamiliesEnumStruct();
/// @returns {Struct.__EventFamiliesEnumStruct}
function __EventFamiliesEnumStruct() constructor {
    ON_MOVE                 = new ENUM_STRUCT(1, "ON_MOVE");
    ON_INTERACT_WITH_OBJECT = new ENUM_STRUCT(2, "ON_INTERACT_WITH_OBJECT");
}

global.EVENT_GROUPS_ENUMS = new __CombatEventGroups();
/// @returns {Struct.__CombatEventGroups}
function __CombatEventGroups() constructor {
    ON_MOVE = {
        TYPE: global.EVENT_FAMILIES.ON_MOVE,
        SUBTYPES: [
            global.EVENT_SUBTYPES_ENUM_ENUM.ON_STEP,
            global.EVENT_SUBTYPES_ENUM_ENUM.ON_ENEMY_STEP,
            global.EVENT_SUBTYPES_ENUM_ENUM.ON_TELEPORT
        ]
    };

    ON_INTERACT_WITH_OBJECT = {
        TYPE: global.EVENT_FAMILIES.ON_INTERACT_WITH_OBJECT,
        SUBTYPES: [
            global.EVENT_SUBTYPES_ENUM_ENUM.ON_ATTACK,
            global.EVENT_SUBTYPES_ENUM_ENUM.ON_HEAL
        ]
    };
}

// ON_MOVE                 = new ENUM_STRUCT(1, "onMove");
// ON_INTERACT_WITH_OBJECT = new ENUM_STRUCT(2, "onInteractWithObject");