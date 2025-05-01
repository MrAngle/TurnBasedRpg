
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
                    var ownerObj = __combatEventEffect.__getAppliesToTurnEntityObj()

                    // var targetTile = getTileBehind(_actionContextStruct.getAction().getInvokerTuEnStruct().getTileLocationStruct(), 
                    //             _actionContextStruct.getAction().getTargetTile().getTileLocationStruct()) ;

                    // var targetTilePosition = helper_calculate_row_and_col_for_direction(DirectionId.LEFT,
                    //      owner.getTileLocationStruct().getRow(), owner.getTileLocationStruct().getCol());
                         
                    // var surroundingTiles = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getSurroundingTiles(_actionContextStruct.getAction().getOriginTargetTile());

                    var getInvokerTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getTileByLocationStruct(owner.getTileLocationStruct());

                    var actionStruct = new ActionStructBuilder(global.ENUMS.ACTION_TYPE.ATTACK)
                        .withInvokerTurnEntityObj(__combatEventEffect.__getAppliesToTurnEntityObj())
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
