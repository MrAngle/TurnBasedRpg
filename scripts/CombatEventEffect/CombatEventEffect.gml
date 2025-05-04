/// @param {Function<Struct.ActionContextStruct, Boolean>} _function
/// @param {String} stepName - Name of the step for logging purposes.
/// @returns {Struct.CombatEventEffectFunction}
function CombatEventEffectFunction(_function, _stepName) constructor {
    run = _function;
    stepName = _stepName == undefined ? "Not defined" : _stepName;
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

    __eventExecutionSteps           = helper_array_concat_front([helper_event_step_EventTypeMustMatch()], _eventExecutionSteps);

    __eventSubtypesEnums            = _eventSubtypesEnums;

    /// @type {Struct.PipelineStepContext}
    __pipelineStepContext           = undefined;

    __appliesToTurnEntityObj        = _appliesToTurnEntityObj;
    __meta                          = {
        __id: helperGenerateUniqueId(),
        __name: _eventEffectName
    }

    getEventSubtypesEnums = function() {
        return __eventSubtypesEnums;
    }

    getAppliesToTurnEntityStruct = function() {
        return getTurnEntityStruct(__appliesToTurnEntityObj);
    }

    getAppliesToTurnEntityObj = function() {
        return __appliesToTurnEntityObj;
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

    __prepareEventPipelineStruct = function(_actionContextStruct) {
        __pipelineStepContext = new PipelineStepContext(_actionContextStruct, self);
    }
    __cleanEventPipelineStruct = function() {
        __pipelineStepContext = undefined;
    }
    
    /// @param {Struct.ActionContextStruct} _actionContextStruct
    /// @returns {Bool} true if triggered, false if not
    __executeSteps = function(_actionContextStruct) {
        logStepStart(__appliesToTurnEntityObj);
        if(__eventExecutionSteps == undefined) {
            LOG_CRITICAL_MESSAGE("CombatEventEffect: executeSteps: __eventExecutionSteps is undefined. EventEffect: " + self.__meta.__name);
            return false;
        }

        for (var i = 0; i < array_length(__eventExecutionSteps); i++) {
            var step = __eventExecutionSteps[i];
            logStepProcessing(step, __appliesToTurnEntityObj, i);
            var result = step.run(__pipelineStepContext);
            if (!result) {
                logStepFailure(step, __appliesToTurnEntityObj, i);
                return false;
            }
        }
        logStepSuccess(step, __appliesToTurnEntityObj);
        return true;
    }

    logStepFailure = function(step, appliesToObj, stepIndex) {
        var appliesToStruct = getTurnEntityStruct(appliesToObj);
        var name = helper_is_definied(appliesToStruct) ? appliesToObj.my_obj_name : "UNKNOWN";
        var idValue = helper_is_definied(appliesToStruct) ? appliesToStruct.getId() : "???";
    
        var message = "❌ Step failed [" + string(step.stepName) + "]"
                    + " | Effect: " + string(self.__meta.__name)
                    + " | Index: " + string(stepIndex)
                    + " | Owner: ID = " + string(idValue)
                    + ", Name = " + string(name);
    
        LOG_DEBUG_MESSAGE(message);
    }

    logStepProcessing = function(step, appliesToObj, stepIndex) {
        var appliesToStruct = getTurnEntityStruct(appliesToObj);
        var name = helper_is_definied(appliesToStruct) ? appliesToObj.my_obj_name : "UNKNOWN";
        var idValue = helper_is_definied(appliesToStruct) ? appliesToStruct.getId() : "???";
    
        var message = "⚙️ Step Processing [" + string(step.stepName) + "]"
                    + " | Effect: " + string(self.__meta.__name)
                    + " | Index: " + string(stepIndex)
                    + " | Owner: ID = " + string(idValue)
                    + ", Name = " + string(name);
    
        LOG_DEBUG_MESSAGE(message);
    }

    logStepStart = function(appliesToObj) {
        var turnEntityStruct = getTurnEntityStruct(appliesToObj);
        var name = helper_is_definied(turnEntityStruct) ? appliesToObj.my_obj_name : "UNKNOWN";
        var tuEnId = helper_is_definied(turnEntityStruct) ? turnEntityStruct.getId() : "UNKNOWN";
    
        var message = "🚀 Effect Start [" + string(self.__meta.__name) + "]"
                    + " | Owner: ID = " + string(tuEnId)
                    + ", Name = " + string(name);
    
        LOG_DEBUG_MESSAGE(message);
    }

    logStepSuccess = function(step, appliesToObj) {
        var turnEntityStruct = getTurnEntityStruct(appliesToObj);
        var name = helper_is_definied(turnEntityStruct) ? appliesToObj.my_obj_name : "UNKNOWN";
        var tuEnId = helper_is_definied(turnEntityStruct) ? turnEntityStruct.getId() : "UNKNOWN";
    
        var message = "✔️ Effect passed [" + string(self.__meta.__name) + "]"
                    + " | Owner: ID = " + string(tuEnId)
                    + ", Name = " + string(name);
    
        LOG_INFO_MESSAGE(message);
    }
}






