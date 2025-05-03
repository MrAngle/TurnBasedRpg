/// @param {Array<Struct.EventParamDefinition>} _fieldsToCheck
/// @param {String} _eventStepName
/// @returns {Struct.CombatEventEffectFunction} _1_checkIfValuesForTriggerCheckConditionAreSet
function helper_event_step_AllFieldsMustBeFilled(_fieldsToCheck, _eventStepName) {
    return {
        __fieldsToCheck: _fieldsToCheck,
        /// @param {Struct.CombatEventEffect} _combatEventEffect
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_combatEventEffect, _actionContextStruct) {
            return _combatEventEffect.__tryAssignAll(__fieldsToCheck, _actionContextStruct)
        },
        stepName: _eventStepName + "_checkIfValuesForTriggerCheckConditionAreSet",
    }
}


