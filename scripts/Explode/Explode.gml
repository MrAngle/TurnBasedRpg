
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

    // var _2_checkIfValuesForTriggerCheckConditionAreSet = {
    //     __pipelineContext: pipelineContext,
    //     /// @param {Struct.PipelineStepContext} _pipelineStepContext
    //     /// @returns {Bool} pass if the effect should be triggered
    //     run: function(_pipelineStepContext) {
    //         var tuEnStruct = getTurnEntityStruct(_pipelineStepContext.get(__pipelineContext.appliesToTurnEntityObj));
    //         if(!is_struct(tuEnStruct)) {
    //             return false ;
    //         }
    //         var appliesToTurnEntityLocation = tuEnStruct.getTileLocationStruct();
    //         if(helper_is_not_definied(appliesToTurnEntityLocation)) {
    //             return false ;
    //         }

    //         _pipelineStepContext.assign(__pipelineContext.appliesToTurnEntityLocationStruct, appliesToTurnEntityLocation);
    //     },
    //     stepName: actionName + "_2_empty",
    // }

    var _2_onTriggerFunc = {
        __pipelineContext: pipelineContext,
        /// @param {Struct.PipelineStepContext} _pipelineStepContext
        /// @returns {Bool} pass if the effect should be triggered
        run: function(_pipelineStepContext) {
            // var getInvokerTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getTileByLocationStruct(owner.getTileLocationStruct());
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

            // var newContext = new ActionContextStruct(actionStruct);
            // var resolved = ActionResolvedStructBuilder(newContext);

            return resolvedActionStruct.execute();
		},
        stepName: actionName + "_2_onTriggerFunc",
    }


    // var _onTriggerFunc = new CombatEventEffectFunction(
    //     /// @param {Struct.CombatEventEffect}
    //     function(_combatEventEffect) {
	// 		return {
    //             /// @type {Struct.CombatEventEffect}
    //             __combatEventEffect: _combatEventEffect,
    //             /// @param {Struct.ActionContextStruct} _actionContextStruct
    //             toReturn: function(_actionContextStruct) {
    //                 var owner = __combatEventEffect.getAppliesToTurnEntityStruct()
    //                 var ownerObj = __combatEventEffect.getAppliesToTurnEntityObj()

    //                 if(helper_is_not_definied(owner)) {
    //                     LOG_CRITICAL_MESSAGE("owner is not defined in COMBAT_EVENT_EFFECT_EXPLODE");
    //                     return;
    //                 }

    //                 var getInvokerTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getTileByLocationStruct(owner.getTileLocationStruct());
                    
    //                 var actionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
    //                     .withInvokerTurnEntityObj(__combatEventEffect.getAppliesToTurnEntityObj())
    //                     .withOriginTargetMapTile([getInvokerTile], new ActionTargetResolver_SURROUNDING_TILES())
    //                     .withActionIntentId(_actionContextStruct.getAction().getFromIntent())
    //                     .withEventTypesEnumArray(global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(global.ENUMS.ACTION_TYPE.ATTACK))
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
    //     [global.EVENT_TYPES_ENUM.ON_GAME_TURN],
    //     _shouldTrigger,
    //     _onTriggerFunc,
    //     _ownerTurnEntityObj,
    //     "EXPLODE"
    // );

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

// function checkIfInvokerIsSame() {
//     return function(_firstActionContextStruct, _secondActionContextStruct) {
//         return _firstActionContextStruct.isSameTurnEntity(_secondActionContextStruct);
//     }
// }
