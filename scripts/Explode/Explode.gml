
/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_EXPLODE(_ownerTurnEntityObj) {
    var actionName = "EXPLODE";
    var PIPE_FLOW = global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.EVENT_EFFECT_FLOW;

    var pipelineContext = {
        appliesToTurnEntityObj: PIPE_FLOW.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_OBJ,
        appliesToTurnEntity_MapTile: PIPE_FLOW.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_STRUCT__MAP_TILE,
    }

    var _1_checkIfValuesForTriggerCheckConditionAreSet = helper_event_step_AllFieldsMustBeFilled(
        [
            pipelineContext.appliesToTurnEntityObj,
            pipelineContext.appliesToTurnEntity_MapTile
        ], 
        actionName
    )

    var _2_onTriggerFunc = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_pipelineStepContext) {
            var appliesToTurnEntity = _pipelineStepContext.get(__pipelineContext.appliesToTurnEntityObj)
            var effectOwnerMapTile = _pipelineStepContext.get(__pipelineContext.appliesToTurnEntity_MapTile)

            var resolvedActionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
                .withInvokerTurnEntityObj(appliesToTurnEntity)
                .withOriginTargetMapTile(
                    [effectOwnerMapTile], 
                    new ActionTargetResolver_SURROUNDING_TILES())
                .withActionIntentId(ACTION_INTENT_ENUM.EVENT)
                .withEventTypesEnumArray(
                    global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(global.ENUMS.ACTION_TYPE.ATTACK))
                .buildAsActionResolver()

            return resolvedActionStruct.execute();
		},
        stepName: actionName + "_2_onTriggerFunc",
    }

    var effect = new CombatEventEffect(
        [   
            _1_checkIfValuesForTriggerCheckConditionAreSet,
            _2_onTriggerFunc,
        ],
        [global.EVENT_TYPES_ENUM.ON_GAME_TURN],
        _ownerTurnEntityObj,
        actionName
    );

    return effect;
}
