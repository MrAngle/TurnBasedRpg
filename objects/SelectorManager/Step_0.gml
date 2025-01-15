if(!helper_struct_is_undefined_or_empty(selectorActionManager) && selectorActionManager.__selector_actions_finished == true) {
	
	var allSelectsList = selectorActionManager.__selector_MySelectorActions;
	
	// resolve move action
	var _charTile = allSelectsList[|0];
	var _destinationTile = allSelectsList[|1];
	
	var resultTile0 = _charTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	var resultTile1 = _destinationTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	
	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
		 resultTile1._properties_map_element_row_index, 
		 resultTile1._properties_map_element_col_index, 
		resultTile0.__character);

	selectorActionManager.destroy();
	selectorActionManager = getMySelectorActionManagerClass();
	
}