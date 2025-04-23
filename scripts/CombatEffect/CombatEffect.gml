
/// @function CombatEventEffect
/// @desc Defines a reactive event-based combat effect (e.g. counterattacks, traps, passive reactions).
///       The effect listens to specific combat event subtypes and executes logic if conditions are met.
///       It is attached to a unit and responds to events happening in the battle context.
/// @constructor
///
/// @param {Array<Real>} _subtypes - List of event subtype IDs this effect reacts to (e.g. [ON_STEP.id, ON_ATTACK.id]).
/// @param {Function} _shouldTrigger - A predicate function (context) => boolean, defines when the effect activates.
/// @param {Function} _onTrigger - Function executed when the effect is triggered. Receives the event context.
/// @param {Id.Instance<TurnEntity>} _appliesTo - The unit that owns this effect and listens for event triggers.
///
/// @returns {Struct.CombatEventEffect}
function CombatEventEffect(_subtypes, _shouldTrigger, _onTrigger, _appliesTo, _eventEffectName) constructor {
    __subtypes        = _subtypes;
    __shouldTrigger   = _shouldTrigger;
    __onTrigger       = _onTrigger;
    __appliesTo       = _appliesTo;
    __meta            = {
        __id: helperGenerateUniqueId(),
        __name: _eventEffectName
    }
}