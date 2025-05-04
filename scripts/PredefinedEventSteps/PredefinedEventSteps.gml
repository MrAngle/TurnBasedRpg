/// @param {Array<Struct.EventParamDefinition>} _fieldsToCheck
/// @param {String} _eventStepName
/// @returns {Struct.CombatEventEffectFunction} _1_checkIfValuesForTriggerCheckConditionAreSet
function helper_event_step_AllFieldsMustBeFilled(_fieldsToCheck, _eventStepName) {
    return {
        __fieldsToCheck: _fieldsToCheck,
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_pipelineStepContext) {
            LOG_DEBUG_MESSAGE("Check fields: " + string(__fieldsToCheck));
            var areFieldsDefined = _pipelineStepContext.tryAssignAll(__fieldsToCheck)
            LOG_DEBUG_MESSAGE("Check status: " + string(areFieldsDefined));
            return areFieldsDefined;
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

/// @param {Struct.EventParamDefinition} _actionInvokerStruct
/// @param {Struct.EventParamDefinition} _appliesToTurnEntityStruct
/// @param {Struct.CombatEventEffectFunction} _1_checkFieldsPresentArg
/// @param {Struct.CombatEventEffectFunction} _2_checkOwnershipArg
/// @returns {Struct.OwnerIsInvokerEffectStepBundle}
function OwnerIsInvokerEffectStepBundle(
        _actionInvokerStruct, 
        _appliesToTurnEntityStruct, 
        _1_checkFieldsPresentArg, 
        _2_checkOwnershipArg) constructor {

    param_actionInvokerStruct = _actionInvokerStruct;
    param_appliesToTurnEntityStruct = _appliesToTurnEntityStruct;

    step_1_checkFieldsPresent = _1_checkFieldsPresentArg;
    step_2_checkOwnershipMatch= _2_checkOwnershipArg
}

/// @desc Creates pipelineContext and steps for checking if effect applies to its invoker.
/// @param {String} effectName - Used for labeling stepName
/// @returns {Struct.OwnerIsInvokerEffectStepBundle}
function helper_event_step_EventEffectsOwnerIsSameAsActionInvoker(effectName, _pipeFlow) {
    var pipelineContext = {
        // INIT
        appliesToTurnEntityStruct: _pipeFlow.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_STRUCT,
        actionInvokerStruct: _pipeFlow.ACTION_CONTEXT.ACTION_INVOKER_STRUCT,
    };

    var step1_checkFieldsPresent = helper_event_step_AllFieldsMustBeFilled(
        [        
            pipelineContext.actionInvokerStruct,
            pipelineContext.appliesToTurnEntityStruct
        ],
        effectName + "_requiredFieldsCheck"
    );

    var step2_checkOwnershipMatch = {
        __pipelineContext: pipelineContext,
        stepName: effectName + "_invokerIsSameTurnEntityStruct",

        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        run: function(_pipelineStepContext) {
            var appliesTo = _pipelineStepContext.get(__pipelineContext.appliesToTurnEntityStruct);
            /// @type {Struct.TurnEntityStruct}
            var invoker = _pipelineStepContext.get(__pipelineContext.actionInvokerStruct);

            return invoker.isSameTurnEntityStruct(appliesTo);
        }
    };

    // return {
    //     pipelineContext: pipelineContext,
    //     steps: [step1_checkFieldsPresent, step2_checkOwnershipMatch]
    // };

    return new OwnerIsInvokerEffectStepBundle(
        pipelineContext.actionInvokerStruct, 
        pipelineContext.appliesToTurnEntityStruct, 
        step1_checkFieldsPresent, 
        step2_checkOwnershipMatch);
}