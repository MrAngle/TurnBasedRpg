

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

/// @param {Id.Instance.AbstTurnEntity} arg_source_char
/// @param {Struct.MyMapTile} arg_target_tile
/// @returns {Struct.ActionExecutorUnitStruct}
function ActionAttackExecutorUnitStruct(arg_source_char, arg_target_tile) constructor {
    if (helper_object_not_exists(arg_source_char) || getTurnEntityStruct(arg_source_char).isDead()) {
        helper_throw_exception("arg_source_char is not defined");
    }
    if (helper_is_not_definied(arg_target_tile)) {
        helper_throw_exception("arg_target_tile is not defined");
    }

    __source_char = arg_source_char;
    __arg_target_tile = arg_target_tile;

    // IMPL
    execute = function() {
        visualsAttackTileObject(__arg_target_tile);
        __performAttackOnTile();
    };

    __performAttackOnTile = function() {
        if(__arg_target_tile.hasTurnEntity()) {
            var targetStruct = __arg_target_tile.getTurnEntityStruct();

            targetStruct.applyHpChange(getTurnEntityStruct(__source_char).getAttackDamage());
        }
    }
}

/// @returns {Struct.ActionExecutorUnitStruct}
function ActionStandExecutorUnitStruct() constructor {
    // IMPL
    execute = function() {
        // do nothing
    };
}