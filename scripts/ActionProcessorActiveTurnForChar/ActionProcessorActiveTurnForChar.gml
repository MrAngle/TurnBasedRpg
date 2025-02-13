function Action_Processor_Make_Turn_Active_For_Char() {
	var closedFunction = {
		toReturn: function(_self, __invoker_char, __selector_MySelectorActions) {
			var _charTile = __selector_MySelectorActions[|0];
	
			var resultTile0 = _charTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;

			//var action = Action_Predefined_Move_In_Radius(3);
			//resultTile0.__character.action_set(action);
			
			//properties_character_to_prepare_actions
			
			global.COMBAT_GLOBALS.MANAGERS.COMBAT_TURN.__set_character_to_prepare_actions(resultTile0.__character);
				
			//global.COMBAT_GLOBALS.MANAGERS.COMBAT_TURN.properties_active_turn_character = resultTile0.__character;
		}
	}
	return closedFunction.toReturn;
}