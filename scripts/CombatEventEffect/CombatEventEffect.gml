/// @param {Function<Struct.ActionContextStruct, Boolean>} __function
/// @returns {Struct.CombatEventEffectFunction}
function CombatEventEffectFunction(__function) constructor {
    toReturn = __function
}

/// @function CombatEventEffect
/// @desc Defines a reactive event-based combat effect (e.g. counterattacks, traps, passive reactions).
///       The effect listens to specific combat event subtypes and executes logic if conditions are met.
///       It is attached to a unit and responds to events happening in the battle context.
/// @constructor
///
/// @param {Array<Struct.ENUM_STRUCT>} _eventSubtypesEnums - List of event subtype IDs this effect reacts to (e.g. [ON_STEP, ON_ATTACK]).
/// @param {CombatEventEffectFunction} _shouldTriggerFunc - Condition for triggering the effect. Function<Struct.ActionContextStruct, Boolean>
///// @param {Function<Struct.ActionContextStruct, Boolean>} _shouldTriggerFunc - Condition for triggering the effect. Function<Struct.ActionContextStruct, Boolean>
/// @param {CombatEventEffectFunction} _onTriggerFunc - Function that performs the effect when triggered. Function<Struct.ActionContextStruct, void>
///// @param {Function<Struct.ActionContextStruct, void>} _onTriggerFunc - Function that performs the effect when triggered. Function<Struct.ActionContextStruct, void>
/// @param {Id.Instance<TurnEntity>} __appliesToTurnEntityObj - The unit that owns this effect and listens for event triggers.
///
/// @returns {Struct.CombatEventEffect}
function CombatEventEffect(_eventSubtypesEnums, _shouldTriggerFunc, _onTriggerFunc, _appliesToTurnEntityObj, _eventEffectName) constructor {

    __eventSubtypesEnums            = _eventSubtypesEnums;
    __shouldTriggerFunc             = _shouldTriggerFunc.toReturn(self).toReturn;
    __onTriggerFunc                 = _onTriggerFunc.toReturn(self).toReturn;
    __appliesToTurnEntityObj        = _appliesToTurnEntityObj;
    __meta                          = {
        __id: helperGenerateUniqueId(),
        __name: _eventEffectName
    }

    /// @returns {Id.Instance<TurnEntity>}
    __getAppliesToTurnEntityObj = function() {
        return __appliesToTurnEntityObj;
    }

    /// @returns {Struct.TurnEntityStruct}
    __getAppliesToTurnEntityStruct = function() {
        return getTurnEntityStruct(__appliesToTurnEntityObj);
    }

    getEventSubtypesEnums = function() {
        return __eventSubtypesEnums;
    }

    /// @param {Struct.ActionContextStruct} _actionContextStruct
    /// @returns {Bool}
    shouldTrigger = function(_actionContextStruct) {
        return __shouldTriggerFunc(_actionContextStruct);
    }

    /// @param {Struct.ActionContextStruct} _actionContextStruct
    /// @returns {Void}
    onTrigger = function(_actionContextStruct) {
        return __shouldTriggerFunc(_actionContextStruct);
    }

    /// @param {Struct.ActionContextStruct} _actionContextStruct
    /// @returns {Bool} czy efekt się aktywował
    tryTrigger = function(_actionContextStruct) {
        var triggeredEventTypes = _actionContextStruct.getEventsTypeEnumsToTrigger();

        var isRelevant = false;
        for (var i = 0; i < array_length(__eventSubtypesEnums); i++) {
            var mySubtype = __eventSubtypesEnums[i];

            for (var j = 0; j < array_length(triggeredEventTypes); j++) {
                if (mySubtype.id == triggeredEventTypes[j].id) {
                    isRelevant = true;
                    break;
                }
            }

            if (isRelevant) break;
        }

        if (!isRelevant) return false;
        if (!__shouldTriggerFunc(_actionContextStruct)) return false;

        __onTriggerFunc(_actionContextStruct);
        return true;
    };
}