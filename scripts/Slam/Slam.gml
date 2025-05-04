
/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_SLAM(_ownerTurnEntityObj) {
    var actionName = "SLAM";
    var PIPE_FLOW = global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.EVENT_EFFECT_FLOW;

    var pipelineContext = {
        // INIT
        actionInvokerObj: PIPE_FLOW.ACTION_CONTEXT.ACTION_INVOKER_OBJ,
        actionInvokerStruct: PIPE_FLOW.ACTION_CONTEXT.ACTION_INVOKER_STRUCT,

        // PREPARE
        appliesToTurnEntityStruct: PIPE_FLOW.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_STRUCT,
        actionCalcTargetTiles: PIPE_FLOW.ACTION_CONTEXT.ACTION_CALC_TARGET_TILES,
    }

    var _1_checkIfValuesForTriggerCheckConditionAreSet = helper_event_step_AllFieldsMustBeFilled(
        [
            pipelineContext.actionInvokerStruct,
            pipelineContext.appliesToTurnEntityStruct
        ], 
        actionName
    )

    var _2_checkShouldTrigger = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_pipelineStepContext) {
            /// @type {Struct.TurnEntityStruct} appliesToTurnEntityStruct
            var appliesToTurnEntityStruct = _pipelineStepContext.get(__pipelineContext.appliesToTurnEntityStruct);
            /// @type {Struct.TurnEntityStruct} actionInvokerStruct
            var actionInvokerStruct = _pipelineStepContext.get(__pipelineContext.actionInvokerStruct);

            return actionInvokerStruct.isSameTurnEntityStruct(appliesToTurnEntityStruct);
        },
        stepName: actionName + "_invokerIsSameTurnEntityStruct",
    }

    var _3_prepareDataForAction = helper_event_step_AllFieldsMustBeFilled(
        [
            pipelineContext.actionInvokerObj,
            pipelineContext.actionCalcTargetTiles
        ], 
        actionName
    )

    var _4_createResolvedAction = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Struct.ActionResolvedStruct}
        run: function(_pipelineStepContext) {
            var invokerObj = _pipelineStepContext.get(__pipelineContext.actionInvokerObj);
            var calculatedTargetTiles = _pipelineStepContext.get(__pipelineContext.actionCalcTargetTiles);

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
        [   
            _1_checkIfValuesForTriggerCheckConditionAreSet,
            _2_checkShouldTrigger,
            _3_prepareDataForAction,
            _4_createResolvedAction
        ],
        [global.EVENT_TYPES_ENUM.ON_ATTACK],
        _ownerTurnEntityObj,
        actionName
    );

    return effect;
}

