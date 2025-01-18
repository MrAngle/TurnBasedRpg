//function Action_Processor_Make_Turn_Active_For_Char(_self, __selector_MySelectorActions) {
//	var _charTile = __selector_MySelectorActions[|0];
	
//	var resultTile0 = _charTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;

//	//var   resultTile0.__character.__properties_action_can_perform
//	var action = Action_Predefined_Move_In_Radius(3);
//	resultTile0.__character.action_set(action);
	
	
	
	
////	if(properties_active_turn_character


////action.start(self);

////var closedAction = function(arg_actionClass) {
////	var closedFunction = {
////		__actionClass: arg_actionClass,
////		toReturn: function(_self) {
////			if(!helper_struct_is_undefined_or_empty(__actionClass) ) {
////				__actionClass.execute(_self);
////			}
////		}
////	}
////	return closedFunction.toReturn;
////}

//	//global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = closedAction(action);

	

//	//global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
//	//	resultTile1._properties_map_element_row_index, 
//	//	resultTile1._properties_map_element_col_index, 
//	//	resultTile0.__character);
//}



function Action_Processor_Make_Turn_Active_For_Char() {
	var closedFunction = {
		toReturn: function(_self, __selector_MySelectorActions) {
			var _charTile = __selector_MySelectorActions[|0];
	
			var resultTile0 = _charTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;

			var action = Action_Predefined_Move_In_Radius(3);
			resultTile0.__character.action_set(action);
				
			global.COMBAT_GLOBALS.MANAGERS.COMBAT_TURN.properties_active_turn_character = resultTile0.__character;
		}
	}
	return closedFunction.toReturn;
}