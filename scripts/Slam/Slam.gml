
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
                    
                    var actionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
                        .withInvokerTurnEntityObj(_actionContextStruct.getAction().getInvokerTuEnObj())
                        .withTargetMapTile(targetTile)
                        .withActionIntentId(_actionContextStruct.getAction().getFromIntent())
                        .withEventTypesEnumArray([global.EVENT_TYPES_ENUM.ON_STAND])
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
