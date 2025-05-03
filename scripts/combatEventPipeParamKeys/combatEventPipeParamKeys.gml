/// @returns {Struct.PipeContext}
/// @param {Struct.ActionContextStruct} _actionContext
/// @param {Struct.CombatEventEffect} _combatEventEffect
function PipeContext(_actionContext = undefined, _combatEventEffect = undefined) constructor {
    actionContext = _actionContext;
    combatEventEffect = _combatEventEffect;
}

/// @returns {Struct.COMBAT_EVENT_PARAM_KEYS}
function COMBAT_EVENT_PARAM_KEYS() constructor {

    ACTION_CONTEXT = {
        ACTION_STRUCT: new EventParamDefinition("ACTION_STRUCT", 
        /// @param {Struct.PipeContext} _pipeContext
        function(_pipeContext) { 
            var actionStruct = _pipeContext.actionContext.getAction();
            return is_struct(actionStruct) ? actionStruct : undefined;
        }),

        ACTION_INVOKER_STRUCT:  new EventParamDefinition("ACTION_INVOKER_STRUCT", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var invokerStruct = _pipeContext.actionContext.getActionInvokerStruct();
                return is_struct(invokerStruct) ? invokerStruct : undefined;
            }
        ),

        ACTION_INVOKER_OBJ:  new EventParamDefinition("ACTION_INVOKER_OBJ", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var invokerObj = _pipeContext.actionContext.getActionInvokerObj();
                return helper_obj_is_turn_entity(invokerObj) ? invokerObj : undefined;
            }
        ),
            
        ACTION_CALC_TARGET_TILES:  new EventParamDefinition("ACTION_CALC_TARGET_TILES", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var calculatedTargetTiles = _pipeContext.actionContext.getAction().calculateGetTargetTiles();

                return helper_array_is_not_empty(calculatedTargetTiles) ? calculatedTargetTiles : undefined;
            }
        ),
            
        ACTION_FROM_INTENT:  new EventParamDefinition("ACTION_FROM_INTENT", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var fromIntent = _pipeContext.actionContext.getAction().getFromIntent();

                return helper_is_boolean(fromIntent) ? fromIntent : undefined;
            }
        )
    }

    COMBAT_EVENT_EFFECT = {
        APPLIES_TO_TURN_ENTITY_STRUCT: new EventParamDefinition("APPLIES_TO_TURN_ENTITY_STRUCT", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var appliesToTurnEntity = _pipeContext.combatEventEffect.getAppliesToTurnEntityStruct();
                return is_struct(appliesToTurnEntity) ? appliesToTurnEntity : undefined;
            }
        )
    }
    
    EVENT_EFFECT_FLOW = {
        ACTION_CONTEXT,
        COMBAT_EVENT_EFFECT
    }

}






///// @returns {Struct.COMBAT_EVENT_PARAM_KEYS}
// function COMBAT_EVENT_PARAM_KEYS() constructor {


//     ACTION_STRUCT = new EventParamDefinition("ACTION_STRUCT", 
//         /// @param {Struct.CombatEventEffect} _combatEventEffect
//         /// @param {Struct.ActionContextStruct} _actionContextStruct
//         function(_combatEventEffect, _actionContextStruct) { 
//             var actionStruct = _actionContextStruct.getAction();
//             return is_struct(actionStruct) ? actionStruct : undefined;
//         }
//     );

//     ACTION_INVOKER_STRUCT = new EventParamDefinition("ACTION_INVOKER_STRUCT", 
//         /// @param {Struct.CombatEventEffect} _combatEventEffect
//         /// @param {Struct.ActionContextStruct} _actionContextStruct
//         function(_combatEventEffect, _actionContextStruct) { 
//             var invokerStruct = _actionContextStruct.getActionInvokerStruct();
//             return is_struct(invokerStruct) ? invokerStruct : undefined;
//         }
//     );

//     ACTION_INVOKER_OBJ = new EventParamDefinition("ACTION_INVOKER_OBJ", 
//         /// @param {Struct.CombatEventEffect} _combatEventEffect
//         /// @param {Struct.ActionContextStruct} _actionContextStruct
//         function(_combatEventEffect, _actionContextStruct) { 
//             var invokerObj = _actionContextStruct.getActionInvokerObj();
//             return helper_obj_is_turn_entity(invokerObj) ? invokerObj : undefined;
//         }
//     );
        
//     ACTION_CALC_TARGET_TILES = new EventParamDefinition("ACTION_CALC_TARGET_TILES", 
//         /// @param {Struct.CombatEventEffect} _combatEventEffect
//         /// @param {Struct.ActionContextStruct} _actionContextStruct
//         function(_combatEventEffect, _actionContextStruct) { 
//             var calculatedTargetTiles = _actionContextStruct.getAction().calculateGetTargetTiles();

//             return helper_array_is_not_empty(calculatedTargetTiles) ? calculatedTargetTiles : undefined;
//         }
//     );
        
//     ACTION_FROM_INTENT = new EventParamDefinition("ACTION_FROM_INTENT", 
//         /// @param {Struct.CombatEventEffect} _combatEventEffect
//         /// @param {Struct.ActionContextStruct} _actionContextStruct
//         function(_combatEventEffect, _actionContextStruct) { 
//             var fromIntent = _actionContextStruct.getAction().getFromIntent();

//             return helper_is_boolean(fromIntent) ? fromIntent : undefined;
//         }
//     );
    
//     APPLIES_TO_TURN_ENTITY_STRUCT = new EventParamDefinition("APPLIES_TO_TURN_ENTITY_STRUCT", 
//         /// @param {Struct.CombatEventEffect} _combatEventEffect
//         /// @param {Struct.ActionContextStruct} _actionContextStruct
//         function(_combatEventEffect, _actionContextStruct) { 
//             var appliesToTurnEntity = _combatEventEffect.getAppliesToTurnEntityStruct();
//             return is_struct(appliesToTurnEntity) ? appliesToTurnEntity : undefined;
//         }
//     );

// }
