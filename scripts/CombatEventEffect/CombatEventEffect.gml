
/// @function CombatEventEffect
/// @desc Defines a reactive event-based combat effect (e.g. counterattacks, traps, passive reactions).
///       The effect listens to specific combat event subtypes and executes logic if conditions are met.
///       It is attached to a unit and responds to events happening in the battle context.
/// @constructor
///
/// @param {Array<Struct.ENUM_STRUCT>} _eventSubtypesEnums - List of event subtype IDs this effect reacts to (e.g. [ON_STEP.id, ON_ATTACK.id]).
/// @param {Function<Struct.ActionContextStruct, Boolean>} _shouldTriggerFunc - Condition for triggering the effect. Function<Struct.ActionContextStruct, Boolean>
/// @param {Function<Struct.ActionContextStruct, void>} _onTriggerFunc - Function that performs the effect when triggered. Function<Struct.ActionContextStruct, void>
/// @param {Id.Instance<TurnEntity>} __appliesToTurnEntityObj - The unit that owns this effect and listens for event triggers.
///
/// @returns {Struct.CombatEventEffect}
function CombatEventEffect(_eventSubtypesEnums, _shouldTriggerFunc, _onTriggerFunc, _appliesToTurnEntityObj, _eventEffectName) constructor {
    __EventSubtypesEnums            = _eventSubtypesEnums;
    __shouldTriggerFunc             = _shouldTriggerFunc;
    __onTriggerFunc                 = _onTriggerFunc;
    __appliesToTurnEntityObj        = _appliesToTurnEntityObj;
    __meta                          = {
        __id: helperGenerateUniqueId(),
        __name: _eventEffectName
    }
}