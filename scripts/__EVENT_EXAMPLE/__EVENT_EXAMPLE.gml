
/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_EXAMPLE(_ownerTurnEntityObj) {
    var actionName = "COMBAT_EVENT_EFFECT_EXAMPLE";
    var PIPE_FLOW = global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.EVENT_EFFECT_FLOW;

    var pipelineContext = {
        // INIT
        actionInvokerObj: PIPE_FLOW.ACTION_CONTEXT.ACTION_INVOKER_OBJ,
        actionInvokerStruct: PIPE_FLOW.ACTION_CONTEXT.ACTION_INVOKER_STRUCT,
        appliesToTurnEntityStruct: PIPE_FLOW.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_STRUCT,

        // PREPARE
        actionCalcTargetTiles: PIPE_FLOW.ACTION_CONTEXT.ACTION_CALC_TARGET_TILES,
    }

    var _0_checkIfValuesForTriggerCheckConditionAreSet = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.CombatEventEffect} _combatEventEffect
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_combatEventEffect, _actionContextStruct) {
            return undefined;
        },
        stepName: actionName + "checkIfValuesForTriggerCheckConditionAreSet",
    }



    var _1_checkIfValuesForTriggerCheckConditionAreSet = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.CombatEventEffect} _combatEventEffect
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_combatEventEffect, _actionContextStruct) {
            return _combatEventEffect.__tryAssignAll([
                __pipelineContext.actionInvokerObj,
                __pipelineContext.actionInvokerStruct,
                __pipelineContext.appliesToTurnEntityStruct], _actionContextStruct)
        },
        stepName: actionName + "checkIfValuesForTriggerCheckConditionAreSet",
    }

    var _2_checkShouldTrigger = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.CombatEventEffect} _combatEventEffect
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_combatEventEffect, _actionContextStruct) {
            /// @type {Struct.TurnEntityStruct} appliesToTurnEntityStruct
            var appliesToTurnEntityStruct = _combatEventEffect.__get(__pipelineContext.appliesToTurnEntityStruct);
            /// @type {Struct.TurnEntityStruct} actionInvokerStruct
            var actionInvokerStruct = _combatEventEffect.__get(__pipelineContext.actionInvokerStruct);

            return actionInvokerStruct.isSameTurnEntityStruct(appliesToTurnEntityStruct);
        },
        stepName: actionName + "checkShouldTrigger",
    }

    var _3_prepareDataForAction = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.CombatEventEffect} _combatEventEffect
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_combatEventEffect, _actionContextStruct) {
            return _combatEventEffect.__tryAssignAll([__pipelineContext.actionCalcTargetTiles], _actionContextStruct)
        },
        stepName: actionName + "prepareDataForAction",
    }

    var _4_createResolvedAction = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.CombatEventEffect} _combatEventEffect
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        /// @returns {Struct.ActionResolvedStruct}
        run: function(_combatEventEffect, _actionContextStruct) {
            var invokerObj = _combatEventEffect.__get(__pipelineContext.actionInvokerObj);
            var calculatedTargetTiles = _combatEventEffect.__get(__pipelineContext.actionCalcTargetTiles);

            var actionResolver = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
                .withInvokerTurnEntityObj(invokerObj)
                .withOriginTargetMapTile(calculatedTargetTiles, new ActionTargetResolver_TargetBehind())
                .withActionIntentId(ACTION_INTENT_ENUM.EVENT)
                .withEventTypesEnumArray([global.EVENT_TYPES_ENUM.ON_STAND])
                .buildAsActionResolver()

            actionResolver.execute();
            return true;
        },
        stepName: actionName + "createResolvedActionAndExecute",
    }


    var effect = new CombatEventEffect(
        [_1_checkIfValuesForTriggerCheckConditionAreSet,_2_checkShouldTrigger,_3_prepareDataForAction,_4_createResolvedAction],
        [global.EVENT_TYPES_ENUM.ON_ATTACK],
        _ownerTurnEntityObj,
        actionName
    );

    return effect;
}

