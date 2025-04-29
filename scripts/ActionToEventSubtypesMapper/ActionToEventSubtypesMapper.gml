function ActionTypeToEventSubtypesEnumMapper() constructor {
    
    /// @param {Enum.__ACTION_TYPE_ENUM}
    mapToEventTypeEnum = function(actionTypeEnum) {
        switch (actionTypeEnum.id) {
            case global.ENUMS.ACTION_TYPE.ATTACK.id:
                return [global.EVENT_TYPES_ENUM.ON_ATTACK];
            case global.ENUMS.ACTION_TYPE.STEP.id:
                return [global.EVENT_TYPES_ENUM.ON_STEP];
            case global.ENUMS.ACTION_TYPE.STAND.id:
                return [global.EVENT_TYPES_ENUM.ON_STAND];
            case global.ENUMS.ACTION_TYPE.ON_GAME_TURN.id:
                return [global.EVENT_TYPES_ENUM.ON_GAME_TURN];
            default:
                LOG_CRITICAL_MESSAGE("Unknown action type" + string(actionTypeEnum.label))
        }
    };
}