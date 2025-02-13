function Action_Processor_Move() {
	var standard_move = function() {
		closedFunction = {
			toReturn: function(_self, __invoker_char, __selector_MySelectorActions) {
				var _destinationTile = __selector_MySelectorActions[|0];

				var resultTile1 = _destinationTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	
				global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
					resultTile1._properties_map_element_row_index, 
					resultTile1._properties_map_element_col_index, 
					__invoker_char);
			}
		}
		return closedFunction.toReturn;
	}
	
	return standard_move();
}
	
//	var _charTile = __selector_MySelectorActions[|0];
//	var _destinationTile = __selector_MySelectorActions[|1];
	
//	var resultTile0 = _charTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
//	var resultTile1 = _destinationTile.__result_SelectorTilesHolderClass.__selector_SelectorTileClass[| 0].__selector_myMapTile;
	
//	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
//		resultTile1._properties_map_element_row_index, 
//		resultTile1._properties_map_element_col_index, 
//		resultTile0.__character);
//}


	//var all_active_characters = function() {
	//	closedFunction = {
	//		toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
	//			var notIncludeThisTilesFunc = mapTile_filter_element_is_not_in_array(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
	//			var containsCharacter = mapTile_filter_element_contains_character();
	//			var isNotPreparedForTurn = mapTile_filter_element_contains_character_and_is_NOT_prepared_for_turn();
	//			//var notIncludeThisTilesFunc = helper_object_is_undefined_or_empty(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
	//		    var tiles_with_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([notIncludeThisTilesFunc, containsCharacter, isNotPreparedForTurn]);
			
	//			return tiles_with_characters;
	//		}
	//	}
	//	return closedFunction.toReturn;
	//}

	//var testselector = MySelectorActionClassOptionalConstrParams();
	//testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;
	//testselector._numberOfTilesToSelect = arg_NumberToSelect;

	//var selectorActionCharacter = MySelectorActionClass(all_active_characters(), testselector);
	
	//return selectorActionCharacter;