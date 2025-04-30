/// @function processGameTurn
/// @param {Real} unitApValue - The AP value of the unit that just acted (possibly exceeding the current turn threshold)
function tryProcessGameTurn(unitApValue) {

    // Reference to the game turn struct
    var gameTurn = global.COMBAT_GLOBALS.GAME_TURN;

    // Check if the AP value exceeds the current turn threshold
    if (unitApValue >= gameTurn.CURRENT_TURN_AP_THRESHOLD) {
        gameTurn.TURN_INDEX += 1;
        gameTurn.LAST_TURN_AP_BOUNDARY += gameTurn.CURRENT_TURN_AP_THRESHOLD;

        // Subtract the threshold AP from all units
        var turnEntities = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getAllTurnEntityStructs();

        for (var i = 0; i < array_length(turnEntities); i++) {
            var unit = turnEntities[i];
            unit.prepareActionPointsForNextTurn(gameTurn.CURRENT_TURN_AP_THRESHOLD);
        }
        
        global.COMBAT_GLOBALS.GAME_TURN.CURRENT_MIN_ACTION_POINTS = getTurnEntityStruct(global.COMBAT_GLOBALS.ACTION.CURRENT_INVOKER_TURN_ENTITY_OBJ).getActionPoints();

        var actionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ON_GAME_TURN)
            .build();
        var context = new ActionContextStruct(actionStruct);
        var resolvedAction = ActionResolvedStructBuilder(context);

        resolvedAction.execute();

        LOG_INFO_MESSAGE("[GAME TURN] New turn started: " + string(gameTurn.TURN_INDEX) + " Threshold: " + string(gameTurn.LAST_TURN_AP_BOUNDARY));
    } else {
        global.COMBAT_GLOBALS.GAME_TURN.CURRENT_MIN_ACTION_POINTS = unitApValue;
    }
}