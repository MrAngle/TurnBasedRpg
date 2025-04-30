
/// @returns {Struct.CombatEventEffect}
function COMBAT_EVENT_EFFECT_EXPLODE(_ownerTurnEntityObj) {

    var _shouldTrigger = new CombatEventEffectFunction(
        /// @param {Struct.CombatEventEffect}
        function(_combatEventEffect) {
			return {
                /// @type {Struct.CombatEventEffect} __combatEventEffect
                __combatEventEffect: _combatEventEffect,
                /// @param {Struct.ActionContextStruct} _actionContextStruct
                toReturn: function(_actionContextStruct) {
                    return true;
                }
            }
		}
    )


    var _onTriggerFunc = new CombatEventEffectFunction(
        /// @param {Struct.CombatEventEffect}
        function(_combatEventEffect) {
			return {
                /// @type {Struct.CombatEventEffect}
                __combatEventEffect: _combatEventEffect,
                /// @param {Struct.ActionContextStruct} _actionContextStruct
                toReturn: function(_actionContextStruct) {

                    var owner = __combatEventEffect.__getAppliesToTurnEntityStruct()

                    // var targetTile = getTileBehind(_actionContextStruct.getAction().getInvokerTuEnStruct().getTileLocationStruct(), 
                    //             _actionContextStruct.getAction().getTargetTile().getTileLocationStruct()) ;

                    var targetTilePosition = helper_calculate_row_and_col_for_direction(DirectionId.LEFT,
                         owner.getTileLocationStruct().getRow(), owner.getTileLocationStruct().getCol())      
                         
                    var targetTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(targetTilePosition[0], targetTilePosition[1]);

                    // nowa akcja – atak na ten sam cel co oryginalny atak

                    var asParams = new ActionStruct_ParamFactory(
                        global.ENUMS.ACTION_TYPE.ATTACK,
                        __combatEventEffect.__getAppliesToTurnEntityObj(),
                        targetTile,
                        undefined,
                        [global.EVENT_TYPES_ENUM.ON_STAND]
                    );
                    var newAction = new ActionStruct(asParams);
        
                    var newContext = new ActionContextStruct(newAction);
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
        "REAR_ASSAULT"
    );

    return effect;
}

// function checkIfInvokerIsSame() {
//     return function(_firstActionContextStruct, _secondActionContextStruct) {
//         return _firstActionContextStruct.isSameTurnEntity(_secondActionContextStruct);
//     }
// }
