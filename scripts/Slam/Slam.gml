/// 

/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_SLAM(_ownerTurnEntityObj) {
    // var effect = noone;

    var shouldTrigger = new CombatEventEffectFunction(
        /// @param {Struct.CombatEventEffect}
        function(_combatEventEffect) {
			return {
                __combatEventEffect: _combatEventEffect,
                toReturn: function(_actionContextStruct) {
                    return _actionContextStruct
                    .getActionInvokerStruct()
                    .isSameTurnEntityStruct(__combatEventEffect.__getAppliesToTurnEntityStruct());
                }
            }
		}
    )


    var _onTriggerFunc = new CombatEventEffectFunction(
        /// @param {Struct.CombatEventEffect}
        function(_combatEventEffect) {
			return {
                __combatEventEffect: _combatEventEffect,
                /// @param {Struct.ActionContextStruct} _actionContextStruct
                toReturn: function(_actionContextStruct) {
                    // nowa akcja – atak na ten sam cel co oryginalny atak
                    var newAction = new ActionStruct(
                        global.ENUMS.ACTION_TYPE.ATTACK,        // typ akcji
                        _actionContextStruct.getAction().getInvokerTuEnObj(),                         // ten sam atakujący
                        _actionContextStruct.getAction().getTargetTile(),                // ten sam cel
                        _actionContextStruct.getAction().getFromIntent(),                // ta sama intencja
                        [global.EVENT_TYPES_ENUM.ON_STAND]
                    );
            
                    var newContext = new ActionContextStruct(newAction);
                    var resolved = ActionResolvedStructBuilder(newContext);

                    resolved.execute();
                }
            }
		}
    )


    // var _onTriggerFunc = {
    //     /// @type {Struct.CombatEventEffect}
	// 	effectParam: effect,
	// 	toReturn: function() {
	// 		return function(_actionContextStruct) {
    //             return _actionContextStruct
    //             .getActionInvokerStruct()
    //             .isSameTurnEntityStruct(effectParam.__getAppliesToTurnEntityStruct());
    //         }
	// 	}
	// }

    var effect = new CombatEventEffect(
        // _eventSubtypesEnums
        [global.EVENT_TYPES_ENUM.ON_ATTACK],
    
        shouldTrigger,
        // _shouldTriggerFunc
        ///// @param {Struct.ActionContextStruct} _actionContextStruct
        // function(_actionContextStruct) {
        //     return _actionContextStruct.getActionInvokerStruct().isSameTurnEntity(
        //         effect.__getAppliesToTurnEntityStruct()
        //     );
        // },
    
        _onTriggerFunc,
        // _onTriggerFunc
        ///// @param {Struct.ActionContextStruct} _actionContextStruct
        // function(_actionContextStruct) {
        //     // nowa akcja – atak na ten sam cel co oryginalny atak
        //     var newAction = new ActionStruct(
        //         global.ActionTypes.ATTACK,        // typ akcji
        //         effect.__getAppliesToTurnEntityStruct(),                         // ten sam atakujący
        //         _actionContextStruct.getAction().getTargetTile(),                // ten sam cel
        //         _actionContextStruct.getAction().getFromIntent(),                // ta sama intencja
        //         [global.EVENT_TYPES_ENUM.ON_STAND]
        //     );
    
        //     var newContext = new ActionContextStruct(newAction);
        //     var resolved = new __ActionResolvedStruct(newContext);
        //     resolved.__INIT();
        //     resolved.execute();
        // },
    
        //_appliesToTurnEntityObj
        _ownerTurnEntityObj,
        //_eventEffectName
        "REAR_ASSAULT"
    );


    // closedFunction.effectParam = effect;
    // effect.__shouldTriggerFunc = closedFunction.toReturn();

    return effect;
}

function checkIfInvokerIsSame() {
    return function(_firstActionContextStruct, _secondActionContextStruct) {
        return _firstActionContextStruct.isSameTurnEntity(_secondActionContextStruct);
    }
}
