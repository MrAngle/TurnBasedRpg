

/// Its only "interface" use specific implementation that implements those methods
/// @returns {Struct.ActionExecutorUnitStruct}
function ActionExecutorUnitStruct() constructor {
    execute = function() {};
}

/// @function performMoveAction(source_char, destination_row, destination_col)
/// @description Wykonuje akcję ruchu postaci na wskazane pole mapy.
/// @param {Id.Instance} arg_source_char - Instancja postaci wykonującej ruch.
/// @param {Real} arg_destinarion_row - Docelowy wiersz na mapie.
/// @param {Real} arg_destination_col - Docelowa kolumna na mapie.
/// @returns {Struct.ActionExecutorUnitStruct}
function ActionStepExecutorUnitStruct(_source_char, _dest_row, _dest_col) constructor {
    __source_char = _source_char;
    __dest_row = _dest_row;
    __dest_col = _dest_col;

    // IMPL
    execute = function() {
        global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
            __dest_row,
            __dest_col,
            __source_char
        );
    };
}

/// @returns {Struct.ActionExecutorUnitStruct}
function ActionAttackExecutorUnitStruct(arg_source_char, arg_target_char) constructor {
    __source_char = arg_source_char;
    __target_char = arg_target_char;

    // IMPL
    execute = function() {
        getTurnEntityAttributes(__target_char).receiveDamage(getTurnEntityAttributes(__source_char).getAttackValue());
    };
}

/// @returns {Struct.ActionExecutorUnitStruct}
function ActionStandExecutorUnitStruct() constructor {
    // IMPL
    execute = function() {
        // do nothing
    };
}