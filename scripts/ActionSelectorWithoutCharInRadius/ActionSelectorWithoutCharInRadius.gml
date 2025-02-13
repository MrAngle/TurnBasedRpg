// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function Action_Selector_Without_Char_In_Radius(arg_invoker_char, arg_base_radius = 1) 
{
	var all_empty_tile_in_distance = function(closed_arg_base_radius, closed_arg_invoker_char) {
		closedFunction = {
			__distance: closed_arg_base_radius,
			__invoker: closed_arg_invoker_char,
			toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
				var tilesWithoutCharactersFunc = mapTile_filter_element_NOT_contains_character();
				
				
				var tilesInDistance = mapTile_filter_within_distance(global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile_by_character(__invoker), __distance)
				//var tilesInDistance = mapTile_filter_within_distance(__previous_result_SelectorTilesHolderClass.get_all_myMapTiles_as_array()[0], __distance);
			    var tiles_without_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([tilesWithoutCharactersFunc, tilesInDistance]);
			
				return tiles_without_characters;
			}
		}
		return closedFunction.toReturn;
	}

	var testselector = MySelectorActionClassOptionalConstrParams();
	testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;
	testselector._numberOfTilesToSelect = 1;
	
	var selectorActionWithoutCharacter = MySelectorActionClass(all_empty_tile_in_distance(arg_base_radius, arg_invoker_char));
	return selectorActionWithoutCharacter;
}
