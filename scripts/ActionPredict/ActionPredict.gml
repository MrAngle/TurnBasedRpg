/// @param {Id.Instance.AbstTurnEntity} _turnEntity
function getActionCostPredict(_turnEntityObj) {
    if(helper_object_not_exists(_turnEntityObj)) {
        return 0;
    }

    var turnEntityStruct = getTurnEntityStruct(_turnEntityObj);
    var surroundingTiles = 
        global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getSurroundingArrayTilesByTileLocation(turnEntityStruct.getTileLocationStruct());

    for (var i = 0; i < array_length(surroundingTiles); i++) {
        var tile = surroundingTiles[i];

        var actionType = tile.hasTurnEntity() ? 
            global.ENUMS.ACTION_TYPE.ATTACK : global.ENUMS.ACTION_TYPE.STEP;

        var action = new ActionStructBuilder(actionType)
            .withInvokerTurnEntityObj(_turnEntityObj)
            // 
            // .withOriginTargetMapTile()
            // .withActionIntentId(intent_id)
            // .withEventTypesEnumArray(global.COMBAT_GLOBALS.MAPPERS.ACTION_TO_EVENT_TYPE.mapToEventTypeEnum(ACTION_TYPE_ENUM))
            .build();

        var actionContext = new ActionContextStruct(action, ACTION_MODE_ENUM.PREDICT);
        var resolvedAction = ActionResolvedStructBuilder(actionContext);
        resolvedAction.execute();

        // actionResolved.execute();
        createActionPredictionObject(
            actionContext.getActionStats().action_cost, 
            tile.getTileLocationStruct(), 
            global.COMBAT_GLOBALS.ACTION.SUB_TURN_COUNT
        );
        // var ac = new ActionContext(/* odpowiednie argumenty */);
        // var action = new Action(/* ... */);
        // var result = action.resolve(ac);
        
        // var cost = result.cost; // zakładając, że ActionResolved ma .cost

        // var inst = instance_create_layer(tile.x, tile.y, "FX", obj_action_cost_display);
        // inst.cost = cost;
    }

        

}

/// @param {Struct.TileLocationStruct} _location
/// @param {real} _actionCost
/// @param {real} _currentSubTurn
function createActionPredictionObject(_actionCost, _location, _currentSubTurn) {
    /// @type {Struct.VisualGenericStruct} visualGenericStruct
    var visualGenericStruct = {
        __actionCost: _actionCost,
        __location: _location,
        __currentSubTurn: _currentSubTurn,
    
        /// @param {Id.Instance.VisualGenericObj} _self
        onCreate: function(_self) {
            _self.actionCost = __actionCost;
            _self.currentSubTurn = __currentSubTurn;
            _self.x = __location.getXPosition();
            _self.y = __location.getYPosition();
        },
        onStep: function(_self) {
        },
        onDestroy: function() {

        },
        /// @param {Id.Instance.VisualGenericObj} _self
        onDraw: function(_self) {
            with (_self) {
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
                var ap_text = "[FNT_actionPointsBar][c_green]" + string(actionCost);
                var text1 = scribble(ap_text);

                var w = text1.get_width();
                var h = text1.get_height();
                
                draw_scribble_with_background(text1, x - w / 2, y - h / 2, c_black);
                draw_set_halign(fa_left); // reset
                draw_set_valign(fa_top);  // reset
            }
        },
        shouldDestroy: function (_self) {
            if(_self.currentSubTurn != global.COMBAT_GLOBALS.ACTION.SUB_TURN_COUNT) {
                return true; // Zmienione na true, aby zniszczyć obiekt
            }
            return false; // Zmienione na false, aby nie niszczyć obiekt
        }
    }
    createVisualGeneric(visualGenericStruct, global.LAYERS.gui_effects.id);
}