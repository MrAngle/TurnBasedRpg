
/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_EXPLODE(_ownerTurnEntityObj) {



    // var _shouldTrigger = new CombatEventEffectFunction(
    //     /// @param {Struct.CombatEventEffect}
    //     function(_combatEventEffect) {
	// 		return {
    //             /// @type {Struct.CombatEventEffect} __combatEventEffect
    //             __combatEventEffect: _combatEventEffect,
    //             /// @param {Struct.ActionContextStruct} _actionContextStruct
    //             toReturn: function(_actionContextStruct) {
    //                 return true;
    //             }
    //         }
	// 	}
    // )

    var actionName = "EXPLODE";

    var pipelineContext = {
        // INIT
        appliesToTurnEntityStruct: global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.APPLIES_TO_TURN_ENTITY_STRUCT,

        // PREPARE
        actionCalcTargetTiles: global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.ACTION_CALC_TARGET_TILES,
    }

    var _1_checkIfValuesForTriggerCheckConditionAreSet = helper_event_step_AllFieldsMustBeFilled(
        [
            pipelineContext.appliesToTurnEntityStruct
        ], 
        actionName
    )

    // var _2_get = {
    //     __pipelineContext: pipelineContext,
    //     /// @param {Struct.CombatEventEffect} _combatEventEffect
    //     /// @param {Struct.ActionContextStruct} _actionContextStruct
    //     /// @returns {Bool} pass if the effect should be triggered
    //     run: function(_combatEventEffect, _actionContextStruct) {
    //         return undefined;
    //     },
    //     stepName: actionName + "checkIfValuesForTriggerCheckConditionAreSet",
    // }


    var _onTriggerFunc = new CombatEventEffectFunction(
        /// @param {Struct.CombatEventEffect}
        function(_combatEventEffect) {
			return {
                /// @type {Struct.CombatEventEffect}
                __combatEventEffect: _combatEventEffect,
                /// @param {Struct.ActionContextStruct} _actionContextStruct
                toReturn: function(_actionContextStruct) {
                    var owner = __combatEventEffect.getAppliesToTurnEntityStruct()
                    var ownerObj = __combatEventEffect.getAppliesToTurnEntityObj()

                    if(helper_is_not_definied(owner)) {
                        LOG_CRITICAL_MESSAGE("owner is not defined in COMBAT_EVENT_EFFECT_EXPLODE");
                        return;
                    }

                    var getInvokerTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getTileByLocationStruct(owner.getTileLocationStruct());
                    
                    var actionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
                        .withInvokerTurnEntityObj(__combatEventEffect.getAppliesToTurnEntityObj())
                        .withOriginTargetMapTile([getInvokerTile], new ActionTargetResolver_SURROUNDING_TILES())
                        .withActionIntentId(_actionContextStruct.getAction().getFromIntent())
                        .withEventTypesEnumArray(global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(global.ENUMS.ACTION_TYPE.ATTACK))
                        .build()
                    var newContext = new ActionContextStruct(actionStruct);
                    var resolved = ActionResolvedStructBuilder(newContext);

                    resolved.execute();
                }
            }
		}
    )

    var effect = new CombatEventEffect(
        // _eventSubtypesEnums
        [global.EVENT_TYPES_ENUM.ON_GAME_TURN],
        _shouldTrigger,
        _onTriggerFunc,
        _ownerTurnEntityObj,
        "EXPLODE"
    );

    return effect;
}

// function checkIfInvokerIsSame() {
//     return function(_firstActionContextStruct, _secondActionContextStruct) {
//         return _firstActionContextStruct.isSameTurnEntity(_secondActionContextStruct);
//     }
// }
