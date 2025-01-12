if(selectorActionManager.__selector_actions_finished == true) {
	
	var allSelectsList = selectorActionManager.__selector_MySelectorActions;
	
	// resolve move action
	var _charTile = allSelectsList[|0];
	var _destinationTile = allSelectsList[|1];
	
	var resultTile0 = _charTile.__result_selectedTiles.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	var resultTile1 = _destinationTile.__result_selectedTiles.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	
	//resultTile0.__character.properties_map_element_row_index = resultTile1._properties_map_element_row_index;
	//resultTile1.__character.properties_map_element_col_index = resultTile1._properties_map_element_col_index;
	
	global.myCombatMapManager.move_to(
		 resultTile1._properties_map_element_row_index, 
		 resultTile1._properties_map_element_col_index, 
		resultTile0.__character);
	
	var testselector = MySelectorActionClassOptionalConstrParams();
	testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;
	testselector._numberOfTilesToSelect = 2;
	var selectorActionCharacter = MySelectorActionClass(selector_select_character(2), testselector);
	var selectorActionWithoutCharacter = MySelectorActionClass(selector_select_tile_without_characters(1));

	var mySelectorActionList = ds_list_create();

	ds_list_add(mySelectorActionList, selectorActionCharacter);
	ds_list_add(mySelectorActionList, selectorActionWithoutCharacter);

	selectorActionManager.destroy();
	selectorActionManager = MySelectorActionManagerClass(mySelectorActionList);
	
}