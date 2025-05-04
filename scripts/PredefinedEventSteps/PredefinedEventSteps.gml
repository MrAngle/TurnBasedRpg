/// @param {Array<Struct.EventParamDefinition>} _fieldsToCheck
/// @param {String} _eventStepName
/// @returns {Struct.CombatEventEffectFunction} _1_checkIfValuesForTriggerCheckConditionAreSet
function helper_event_step_AllFieldsMustBeFilled(_fieldsToCheck, _eventStepName) {
    return {
        __fieldsToCheck: _fieldsToCheck,
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_pipelineStepContext) {
            return _pipelineStepContext.tryAssignAll(__fieldsToCheck)
        },
        stepName: _eventStepName + "_checkIfValuesForTriggerCheckConditionAreSet",
    }
}

/// @returns {Bool} czy efekt się aktywował
function helper_event_step_EventTypeMustMatch() {

    return {
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_pipelineStepContext) {
            var PIPE_FLOW = global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.EVENT_EFFECT_FLOW;
            if(!_pipelineStepContext.tryAssign(PIPE_FLOW.ACTION_CONTEXT.ACTION_EVENTS_TYPE_ENUMS_TO_TRIGGER)) {
                return false;
            }
            if(!_pipelineStepContext.tryAssign(PIPE_FLOW.COMBAT_EVENT_EFFECT.EVENT_SUBTYPES_ENUMS)) {
                return false;
            }

            var triggeredEventTypes = _pipelineStepContext.get(PIPE_FLOW.ACTION_CONTEXT.ACTION_EVENTS_TYPE_ENUMS_TO_TRIGGER);
            var eventSubtypesEnums = _pipelineStepContext.get(PIPE_FLOW.COMBAT_EVENT_EFFECT.EVENT_SUBTYPES_ENUMS);

            var isRelevant = false;
            for (var i = 0; i < array_length(eventSubtypesEnums); i++) {
                var mySubtype = eventSubtypesEnums[i];
        
                for (var j = 0; j < array_length(triggeredEventTypes); j++) {
                    if (mySubtype.id == triggeredEventTypes[j].id) {
                        isRelevant = true;
                        break;
                    }
                }
        
                if (isRelevant) break;
            }
        
            if (!isRelevant) return false;
            return true;
        },
        stepName: "INIT_CheckEventTypesStep"
    }
}
