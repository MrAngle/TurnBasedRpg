function Action_Processor_Make_Turn_Active_For_Char() {
	var closedFunction = {
		toReturn: function(_self, __invoker_char, __selector_MySelectorActions) {
			var _charTile = __selector_MySelectorActions[|0];
	
			var resultTile0 = _charTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
			
			global.COMBAT_GLOBALS.MANAGERS.COMBAT_TURN.__set_character_to_prepare_actions(resultTile0.__character);
		}
	}
	return closedFunction.toReturn;
}