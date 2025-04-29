

global.EVENT_TYPES_ENUM = new __EventTypesEnum();
/// @returns {Struct.__EventTypesEnum}
function __EventTypesEnum() constructor {
    ON_STEP         = new ENUM_STRUCT(100, "ON_STEP");
    ON_ENEMY_STEP   = new ENUM_STRUCT(101, "ON_ENEMY_STEP");
    ON_TELEPORT     = new ENUM_STRUCT(102, "ON_TELEPORT");

    ON_ATTACK       = new ENUM_STRUCT(200, "ON_ATTACK");
    ON_HEAL         = new ENUM_STRUCT(201, "ON_HEAL");

    ON_STAND         = new ENUM_STRUCT(300, "ON_STAND");
    ON_GAME_TURN     = new ENUM_STRUCT(400, "ON_GAME_TURN");
}

///// @returns {Array<ENUM_STRUCT>}
// function getSubtypesFor_Move() {
//     return [
//         global.EVENT_SUBTYPES_ENUM.ON_STEP,
//         global.EVENT_SUBTYPES_ENUM.ON_ENEMY_STEP,
//         global.EVENT_SUBTYPES_ENUM.ON_TELEPORT
//     ];
// }

// function getSubtypesFor_Interact() {
//     return [
//         global.EVENT_SUBTYPES_ENUM.ON_ATTACK,
//         global.EVENT_SUBTYPES_ENUM.ON_HEAL
//     ];
// }