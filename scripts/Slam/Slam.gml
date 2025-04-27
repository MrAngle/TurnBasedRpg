
/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_SLAM(_ownerTurnEntityObj) {

    var _shouldTrigger = new CombatEventEffectFunction(
        /// @param {Struct.CombatEventEffect}
        function(_combatEventEffect) {
			return {
                /// @type {Struct.CombatEventEffect} __combatEventEffect
                __combatEventEffect: _combatEventEffect,
                /// @param {Struct.ActionContextStruct} _actionContextStruct
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
                    var targetTile = getTileBehind(_actionContextStruct.getAction().getInvokerTuEnStruct().getTileLocationStruct(), 
                                _actionContextStruct.getAction().getTargetTile().getTileLocationStruct()) ;
                    // nowa akcja – atak na ten sam cel co oryginalny atak
                    var newAction = new ActionStruct(
                        global.ENUMS.ACTION_TYPE.ATTACK,
                        _actionContextStruct.getAction().getInvokerTuEnObj(),
                        targetTile,
                        _actionContextStruct.getAction().getFromIntent(),
                        [global.EVENT_TYPES_ENUM.ON_STAND]
                    );
            
                    var newContext = new ActionContextStruct(newAction);
                    var resolved = ActionResolvedStructBuilder(newContext);

                    resolved.execute();
                }
            }
		}
    )

    var effect = new CombatEventEffect(
        // _eventSubtypesEnums
        [global.EVENT_TYPES_ENUM.ON_ATTACK],
        _shouldTrigger,
        _onTriggerFunc,
        _ownerTurnEntityObj,
        "REAR_ASSAULT"
    );

    return effect;
}

function checkIfInvokerIsSame() {
    return function(_firstActionContextStruct, _secondActionContextStruct) {
        return _firstActionContextStruct.isSameTurnEntity(_secondActionContextStruct);
    }
}
