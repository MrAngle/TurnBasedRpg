function ActionTypeToEventSubtypesEnumMapper() constructor {
    
    /// @param {Enum.__ACTION_TYPE_ENUM}
    mapToEventTypeEnum = function(actionTypeEnum) {
        switch (actionTypeEnum.id) {
            case global.ENUMS.ACTION_TYPE.ATTACK.id:
                return [global.EVENT_TYPES_ENUM.ON_ATTACK];
            case global.ENUMS.ACTION_TYPE.STEP.id:
                return [global.EVENT_TYPES_ENUM.ON_STEP];
            default:
                return [global.EVENT_TYPES_ENUM.ON_STAND];
        }
    };
}