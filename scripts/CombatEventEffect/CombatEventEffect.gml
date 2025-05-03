


function EventParamDefinition(_name, _checkFunction) constructor {
    name = _name;
    getFunction = _checkFunction;
}

global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS = new COMBAT_EVENT_PARAM_KEYS();

/// @param {Function<Struct.ActionContextStruct, Boolean>} _function
/// @param {String} stepName - Name of the step for logging purposes.
/// @returns {Struct.CombatEventEffectFunction}
function CombatEventEffectFunction(_function, _stepName) constructor {
    run = _function;
    stepName = _stepName == undefined ? "Not defined" : _stepName;
}

function EventPipelineStruct(_actionContext, _combatEventEffect) constructor {
    __pipeContext = new PipeContext(_actionContext, _combatEventEffect);
}

/// @function CombatEventEffect
/// @desc Defines a reactive event-based combat effect (e.g. counterattacks, traps, passive reactions).
///       The effect listens to specific combat event subtypes and executes logic if conditions are met.
///       It is attached to a unit and responds to events happening in the battle context.
/// @constructor
///
/// @param {Array<Struct.CombatEventEffectFunction>} _eventExecutionSteps - List of functions to execute in order when the event is triggered.
/// @param {Array<Struct.ENUM_STRUCT>} _eventSubtypesEnums - List of event subtype IDs this effect reacts to (e.g. [ON_STEP, ON_ATTACK]).
/// @param {Id.Instance<TurnEntity>} _appliesToTurnEntityObj - The unit that owns this effect and listens for event triggers.
/// @param {String} _eventEffectName - Name of the effect for identification and logging purposes.
/// @returns {Struct.CombatEventEffect}
function CombatEventEffect(
        _eventExecutionSteps,
        _eventSubtypesEnums, 
        _appliesToTurnEntityObj, 
        _eventEffectName) constructor {

    __eventExecutionSteps           = helper_array_concat_front([__checkEventTypesStep()], _eventExecutionSteps);

    __eventSubtypesEnums            = _eventSubtypesEnums;

    /// @type {Struct.EventPipelineStruct}
    __eventPipelineStruct           = undefined;

    __appliesToTurnEntityObj        = _appliesToTurnEntityObj;
    __meta                          = {
        __id: helperGenerateUniqueId(),
        __name: _eventEffectName
    }

    getAppliesToTurnEntityStruct = function() {
        return getTurnEntityStruct(__appliesToTurnEntityObj);
    }

    getAppliesToTurnEntityObj = function() {
        return __appliesToTurnEntityObj;
    }

    /// @param {Struct.EventParamDefinition} _eventParamDefinition
    __get = function(_eventParamDefinition) {
        return variable_struct_get(__eventPipelineStruct, _eventParamDefinition.name);
    }

    /// @param {Array<Struct.EventParamDefinition>} _eventParamsDefinitions
    /// @param {Struct.ActionContextStruct} _actionContextStruct
    __tryAssignAll = function(_eventParamsDefinitions, _actionContextStruct) {
        var allSet = true;
        for (var i = 0; i < array_length(_eventParamsDefinitions); i++) {
            var paramDef = _eventParamsDefinitions[i];
            if(!__tryAssign(paramDef, _actionContextStruct)) {
                allSet = false;
            }
        }
        return allSet;
    }

    /// @param {Struct.EventParamDefinition} _eventParamDefinition
    /// @param {Struct.ActionContextStruct} _actionContextStruct
    __tryAssign = function(_eventParamDefinition, _actionContextStruct) {
        var _combatEventParam = _eventParamDefinition.getFunction(__eventPipelineStruct.__pipeContext);

        if(_combatEventParam == undefined) {
            LOG_INFO_MESSAGE("CombatEventEffect: tryAssign: _combatEventParam is undefined. EventParamDefinition: " + _eventParamDefinition.name);
            return false;
        }

        variable_struct_set(__eventPipelineStruct, _eventParamDefinition.name, _combatEventParam);
        return true
    }

    __prepareEventPipelineStruct = function(_actionContextStruct) {
        __eventPipelineStruct = new EventPipelineStruct(_actionContextStruct, self);
    }
    __cleanEventPipelineStruct = function() {
        __eventPipelineStruct = undefined;
    }
    
    /// @param {Struct.ActionContextStruct} _actionContextStruct
    /// @returns {Bool} true if triggered, false if not
    __executeSteps = function(_actionContextStruct) {
        if(__eventExecutionSteps == undefined) {
            LOG_CRITICAL_MESSAGE("CombatEventEffect: executeSteps: __eventExecutionSteps is undefined. EventEffect: " + self.__meta.__name);
            return false;
        }

        for (var i = 0; i < array_length(__eventExecutionSteps); i++) {
            var step = __eventExecutionSteps[i];
            var result = step.run(self, _actionContextStruct);
            if (!result) {
                LOG_DEBUG_MESSAGE("🔸 Step failed: " + step.stepName + " index: " + string(i));
                return false;
            }
        }
        LOG_INFO_MESSAGE("✅ EFFECT ACTIVATED: " + self.__meta.__name + " index: " + string(i));
        return true;
    }

    /// @param {Struct.ActionContextStruct} _actionContextStruct
    /// @returns {Bool} czy efekt się aktywował
    execute = function(_actionContextStruct) {
        if(!is_struct(_actionContextStruct)) {
            LOG_CRITICAL_MESSAGE("CombatEventEffect: execute: _actionContextStruct is not a struct. EventEffect: " + self.__meta.__name);
            return false;
        }
        __prepareEventPipelineStruct(_actionContextStruct);
        // checkEventTypes(_actionContextStruct);
        __executeSteps(_actionContextStruct);
        __cleanEventPipelineStruct();
    }

}

/// @returns {Bool} czy efekt się aktywował
function __checkEventTypesStep() {

    return {
        /// @param {Struct.CombatEventEffect} _combatEventEffect
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_combatEventEffect, _actionContextStruct) {
            var triggeredEventTypes = _actionContextStruct.getEventsTypeEnumsToTrigger();

            var isRelevant = false;
            for (var i = 0; i < array_length(_combatEventEffect.__eventSubtypesEnums); i++) {
                var mySubtype = _combatEventEffect.__eventSubtypesEnums[i];
        
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




