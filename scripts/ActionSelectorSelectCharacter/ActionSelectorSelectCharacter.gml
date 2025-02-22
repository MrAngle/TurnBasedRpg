// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377


//function Action_Selector_All_Active_Chars(arg_NumberToSelect = 1) 
//{
//	var all_active_characters = function() {
//		closedFunction = {
//			toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
//				var notIncludeThisTilesFunc = mapTile_filter_element_is_not_in_array(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
//				var containsCharacter = mapTile_filter_element_contains_character();
//				//var notIncludeThisTilesFunc = helper_object_is_undefined_or_empty(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
//			    var tiles_with_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([notIncludeThisTilesFunc, containsCharacter]);
			
//				return tiles_with_characters;
//			}
//		}
//		return closedFunction.toReturn;
//	}

//	var testselector = MySelectorActionClassOptionalConstrParams();
//	testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;
//	testselector._numberOfTilesToSelect = arg_NumberToSelect;

//	var selectorActionCharacter = MySelectorActionClass(all_active_characters(), testselector);
	
//	return selectorActionCharacter;
//}


function Action_Selector_All_Active_Chars_Without_Selected_Actions(arg_ActionSelectorProperties) 
{
	//var all_active_characters = function() {
	//	closedFunction = {
	//		toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
	//			//var notIncludeThisTilesFunc = mapTile_filter_element_is_not_in_array(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
	//			var containsCharacter = mapTile_filter_element_contains_character();
	//			var isNotPreparedForTurn = mapTile_filter_element_contains_character_and_is_NOT_prepared_for_turn();
	//			//var notIncludeThisTilesFunc = helper_object_is_undefined_or_empty(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
	//		    var tiles_with_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([//notIncludeThisTilesFunc
	//				containsCharacter, isNotPreparedForTurn]);
			
	//			return tiles_with_characters;
	//		}
	//	}
	//	return closedFunction.toReturn;
	//}

	var testselector = MySelectorActionClassOptionalConstrParams();
	testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;
	testselector._numberOfTilesToSelect = 1;

	var selectorActionCharacter = MySelectorActionClass(arg_ActionSelectorProperties, testselector);
	
	return selectorActionCharacter;
}