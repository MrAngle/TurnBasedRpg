/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_DASHATTACK(_ownerTurnEntityObj) {
    var effectName = "DashAttack";
    var PIPE_FLOW = global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.EVENT_EFFECT_FLOW;

    // var pipelineContext = {
    //     appliesToTurnEntityObj: PIPE_FLOW.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_OBJ,
    //     appliesToTurnEntity_MapTile: PIPE_FLOW.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_STRUCT__MAP_TILE,
    // }

    // var _1_checkIfValuesForTriggerCheckConditionAreSet = helper_event_step_AllFieldsMustBeFilled(
    //     [
    //         pipelineContext.appliesToTurnEntityObj,
    //         pipelineContext.appliesToTurnEntity_MapTile
    //     ], 
    //     actionName
    // )

    var ownerSameAsInvoker 
        = helper_event_step_EventEffectsOwnerIsSameAsActionInvoker(effectName, PIPE_FLOW)

    var pipelineParamsContext = {
        // INIT
        appliesToTurnEntityStruct: ownerSameAsInvoker.param_actionInvokerStruct,
        actionInvokerStruct: ownerSameAsInvoker.param_actionInvokerStruct,

        // PREPARE
        actionInvokerObj: PIPE_FLOW.ACTION_CONTEXT.ACTION_INVOKER_OBJ,
        actionCalcTargetTiles: PIPE_FLOW.ACTION_CONTEXT.ACTION_CALC_TARGET_TILES,
    }



    // var _shouldTrigger = new CombatEventEffectFunction(
    //     /// @param {Struct.CombatEventEffect}
    //     /// @param {Struct.ActionContextStruct} _actionContextStruct
    //     /// @returns {Bool} pass if the effect should be triggered
    //     function(_combatEventEffect, _actionContextStruct) {
    //         return _actionContextStruct
    //         .getActionInvokerStruct()
    //         .isSameTurnEntityStruct(__combatEventEffect.getAppliesToTurnEntityStruct());
    //     }
    // )

    
    var _3_checkIfValuesForTriggerCheckConditionAreSet = helper_event_step_AllFieldsMustBeFilled(
        [
            pipelineParamsContext.actionInvokerObj,
            pipelineParamsContext.actionCalcTargetTiles
        ], 
        effectName
    )
    
    var _4_createResolvedAction = {
        __pipelineParamsContext: pipelineParamsContext,
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Struct.ActionResolvedStruct}
        run: function(_pipelineStepContext) {
            var actionInvokerObj = _pipelineStepContext.get(__pipelineParamsContext.actionInvokerObj);
            var actionCalcTargetTiles = _pipelineStepContext.get(__pipelineParamsContext.actionCalcTargetTiles);

            var resolvedActionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
            .withInvokerTurnEntityObj(actionInvokerObj)
            .withOriginTargetMapTile(
                actionCalcTargetTiles,
                new ActionTargetResolver_ClosedEnemy())
            .withActionIntentId(ACTION_INTENT_ENUM.EVENT)
            .withEventTypesEnumArray([global.EVENT_TYPES_ENUM.ON_ATTACK])
            .buildAsActionResolver()

            // var newContext = new ActionContextStruct(actionStruct);
            // var resolved = ActionResolvedStructBuilder(newContext);

            resolvedActionStruct.execute();
            return true;
        },
        stepName: effectName + "_createResolvedActionAndExecute",
    }


    var effect = new CombatEventEffect(
        [   
            ownerSameAsInvoker.step_1_checkFieldsPresent,
            ownerSameAsInvoker.step_2_checkOwnershipMatch,
            // _1_checkIfValuesForTriggerCheckConditionAreSet,
            // _2_checkShouldTrigger,
            _3_checkIfValuesForTriggerCheckConditionAreSet,
            _4_createResolvedAction
        ],
        [global.EVENT_TYPES_ENUM.ON_STEP],
        _ownerTurnEntityObj,
        effectName
    );


    // var _onTriggerFunc = new CombatEventEffectFunction(
    //     /// @param {Struct.CombatEventEffect}
    //     function(_combatEventEffect) {
	// 		return {
    //             __combatEventEffect: _combatEventEffect,
    //             /// @param {Struct.ActionContextStruct} _actionContextStruct
    //             toReturn: function(_actionContextStruct) {
    //                 var actionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
    //                     .withInvokerTurnEntityObj(_actionContextStruct.getAction().getInvokerTuEnObj())
    //                     .withOriginTargetMapTile(
    //                         _actionContextStruct.getAction().calculateGetTargetTiles(), 
    //                         new ActionTargetResolver_ClosedEnemy())
    //                     .withActionIntentId(_actionContextStruct.getAction().getFromIntent())
    //                     .withEventTypesEnumArray([])
    //                     .build()

    //                 var newContext = new ActionContextStruct(actionStruct);
    //                 var resolved = ActionResolvedStructBuilder(newContext);

    //                 resolved.execute();
    //             }
    //         }
	// 	}
    // )

    // var effect = new CombatEventEffect(
    //     // _eventSubtypesEnums
    //     [global.EVENT_TYPES_ENUM.ON_STEP],
    //     _shouldTrigger,
    //     _onTriggerFunc,
    //     _ownerTurnEntityObj,
    //     "DASH_ATTACK"
    // );

    return effect;
}