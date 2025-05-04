global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS = new COMBAT_EVENT_PARAM_KEYS();

/// @description Defines grouped parameter accessors used in combat event pipelines.
/// @details
/// Each EventParamDefinition is a self-contained resolver responsible only for computing and returning
/// its own specific value based on the given PipeContext (which includes ActionContext and CombatEventEffect).
///
/// Design principles:
/// - Each parameter definition must resolve only its own value.
/// - It must not modify or store values for other parameters in the pipeline context.
/// - A parameter must be designed to function independently — it should not assume the existence or availability
///   of other parameters, even if logically related.
/// - If a step needs multiple related values (e.g., struct and its tile location), it is the step’s
///   responsibility to explicitly resolve and store each one as needed, potentially using one to derive another.
/// - No parameter should implicitly cache or write values beyond itself — all context updates should be intentional
///   and performed by the step logic if multiple values are required.
///
/// Group structure:
/// Parameter definitions are grouped by source origin — for example:
/// - `ACTION_CONTEXT` contains resolvers that extract data from the ActionContextStruct
/// - `COMBAT_EVENT_EFFECT` contains resolvers that extract data from the CombatEventEffect
///
/// You can compose these groups into a named pipeline input scope using a structure such as:
///
/// EVENT_EFFECT_FLOW = {
///     ACTION_CONTEXT,
///     COMBAT_EVENT_EFFECT
/// }
///
/// These groups not only organize parameters by source but also serve as a **contract**:
/// Any step or effect that references a group (e.g., `ACTION_CONTEXT`) implicitly assumes
/// that the corresponding source (e.g., `pipeContext.actionContext`) **will be available and initialized**
/// at the time of execution.
///
/// This ensures that parameter resolution is safe and predictable — steps can rely on source presence
/// without adding repetitive safety checks.
///
/// Example:
/// Step 1 resolves `APPLIES_TO_TURN_ENTITY_STRUCT` and stores it in the pipeline context.
/// Step 2 needs `APPLIES_TO_TURN_ENTITY_STRUCT__TILE_LOCATION`, which is derived from the struct.
/// To avoid redundant checks or re-resolution, the step can read the already-resolved struct,
/// extract the tile location from it, and store that value under the TILE_LOCATION key:
///
/// var struct = ensureResolved(ctx, APPLIES_TO_TURN_ENTITY_STRUCT);
/// if (is_struct(struct)) {
///     var tileLoc = struct.getTileLocationStruct();
///     if (tileLoc != undefined) {
///         ctx.set(APPLIES_TO_TURN_ENTITY_STRUCT__TILE_LOCATION, tileLoc);
///     }
/// }
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

                return helper_is_definied(fromIntent) ? fromIntent : undefined;
            }
        ),

        ACTION_EVENTS_TYPE_ENUMS_TO_TRIGGER:  new EventParamDefinition("ACTION_EVENTS_TYPE_ENUMS_TO_TRIGGER", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var eventsTypeEnumsToTrigger = _pipeContext.actionContext.getEventsTypeEnumsToTrigger();

                return is_array(eventsTypeEnumsToTrigger) ? eventsTypeEnumsToTrigger : undefined;
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
        ),

        APPLIES_TO_TURN_ENTITY_OBJ: new EventParamDefinition("APPLIES_TO_TURN_ENTITY_OBJ", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var appliesToTurnEntity = _pipeContext.combatEventEffect.getAppliesToTurnEntityObj();
                return helper_obj_is_turn_entity(appliesToTurnEntity) ? appliesToTurnEntity : undefined;
            }
        ),

        APPLIES_TO_TURN_ENTITY_STRUCT__TILE_LOCATION: new EventParamDefinition("APPLIES_TO_TURN_ENTITY_STRUCT__TILE_LOCATION", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) {
                var parentParam = global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_STRUCT;
                /// @type {Struct.TurnEntityStruct} turnEntityStruct
                var turnEntityStruct = parentParam.getFunction(_pipeContext);

                if(turnEntityStruct == undefined) {
                    return undefined;
                }

                var tileLocation = turnEntityStruct.getTileLocationStruct();
                return is_struct(tileLocation) ? tileLocation : undefined;
            }
        ),

        APPLIES_TO_TURN_ENTITY_STRUCT__MAP_TILE: new EventParamDefinition("APPLIES_TO_TURN_ENTITY_STRUCT__MAP_TILE", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) {
                var appliesToTileLocationParam = global.COMBAT_COMBAT_EVENT_PIPE_PARAM_KEYS.COMBAT_EVENT_EFFECT.APPLIES_TO_TURN_ENTITY_STRUCT__TILE_LOCATION;
                var appliesToTileLocation = appliesToTileLocationParam.getFunction(_pipeContext);

                if(appliesToTileLocation == undefined) {
                    return undefined;
                }

                var myMapTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getTileByLocationStruct(appliesToTileLocation);
                return is_struct(myMapTile) ? myMapTile : undefined;
            }
        ),

        EVENT_SUBTYPES_ENUMS: new EventParamDefinition("EVENT_SUBTYPES_ENUMS", 
            /// @param {Struct.PipeContext} _pipeContext
            function(_pipeContext) { 
                var eventSubtypesEnums = _pipeContext.combatEventEffect.getEventSubtypesEnums();
                return is_array(eventSubtypesEnums) ? eventSubtypesEnums : undefined;
            }
        )
    }
    
    EVENT_EFFECT_FLOW = {
        ACTION_CONTEXT,
        COMBAT_EVENT_EFFECT
    }
}


/// @returns {Struct.PipeContext}
/// @param {Struct.ActionContextStruct} _actionContext
/// @param {Struct.CombatEventEffect} _combatEventEffect
function PipeContext(_actionContext = undefined, _combatEventEffect = undefined) constructor {
    actionContext = _actionContext;
    combatEventEffect = _combatEventEffect;
}

function EventParamDefinition(_name, _checkFunction) constructor {
    name = _name;
    getFunction = _checkFunction;
}

function PipelineStepContext(_actionContext, _combatEventEffect) constructor {
    __pipeContext = new PipeContext(_actionContext, _combatEventEffect);

    /// @param {Array<Struct.EventParamDefinition>} _eventParamsDefinitions
    tryAssignAll = function(_eventParamsDefinitions) {
        var allSet = true;
        for (var i = 0; i < array_length(_eventParamsDefinitions); i++) {
            var paramDef = _eventParamsDefinitions[i];
            if(!tryAssign(paramDef)) {
                allSet = false;
            }
        }
        return allSet;
    }

    /// @param {Struct.EventParamDefinition} _eventParamDefinition
    tryAssign = function(_eventParamDefinition) {
        var _combatEventParam = _eventParamDefinition.getFunction(self.__pipeContext);

        if(_combatEventParam == undefined) {
            LOG_INFO_MESSAGE("EventPipelineStruct: tryAssign: _combatEventParam is undefined. EventParamDefinition: " + _eventParamDefinition.name);
            return false;
        }

        variable_struct_set(self, _eventParamDefinition.name, _combatEventParam);
        return true
    }

    assign = function(_eventParamDefinition, value) {
        variable_struct_set(self, _eventParamDefinition.name, value);
    }

    /// @param {Struct.EventParamDefinition} _eventParamDefinition
    get = function(_eventParamDefinition) {
        return variable_struct_get(self, _eventParamDefinition.name);
    }

    // Params FILLED IN THE PIPELINE!
}