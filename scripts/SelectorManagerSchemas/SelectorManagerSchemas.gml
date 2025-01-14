// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function getMySelectorActionManagerClass() 
{
	var selector_select_character = function(_numberOfCharacters) {
		closedFunction = {
			closedNumberOfCharacters: _numberOfCharacters,
			toReturn: function(_self, closed_properties_selector_selected_tiles) {
				var _MyMapTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

				if(_MyMapTile.has_character() /*&& !closed_properties_selector_selected_tiles.contains_tile(_MyMapTile) */) {
					closed_properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
				}
			}
		}
		return closedFunction.toReturn;
	}

	var  selector_select_tile_without_characters = function(_numberOfTilesToSelect) {
		closedFunction = {
			closed_numberOfTilesToSelect: _numberOfTilesToSelect,
			//closed_properties_selector_selected_tiles: properties_selector_selected_tiles,
			toReturn: function(_self, closed_properties_selector_selected_tiles) {
				var _MyMapTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

				if(!_MyMapTile.has_character()) {
					closed_properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
				}
			}
		}
		return closedFunction.toReturn;
	}

	var all_active_characters = function() {
		closedFunction = {
			toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
				var notIncludeThisTilesFunc = mapTile_filter_element_is_not_in_array(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
				var containsCharacter = mapTile_filter_element_contains_character();
				//var notIncludeThisTilesFunc = helper_object_is_undefined_or_empty(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
			    var tiles_with_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles_with_characters([notIncludeThisTilesFunc, containsCharacter]);
			
				return tiles_with_characters;
			}
		}
		return closedFunction.toReturn;
	}

	var all_empty_tile = function() {
		closedFunction = {
			toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
				var tilesWithoutCharactersFunc = mapTile_filter_element_NOT_contains_character();
			    var tiles_without_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles_with_characters([tilesWithoutCharactersFunc]);
			
				return tiles_without_characters;
			}
		}
		return closedFunction.toReturn;
	}

	var all_empty_tile_in_distance = function(_distance = 2) {
		closedFunction = {
			__distance: _distance,
			toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
				var tilesWithoutCharactersFunc = mapTile_filter_element_NOT_contains_character();
				var tilesInDistance = mapTile_filter_within_distance(__previous_result_SelectorTilesHolderClass.get_all_myMapTiles_as_array()[0], __distance);
			    var tiles_without_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles_with_characters([tilesWithoutCharactersFunc, tilesInDistance]);
			
				return tiles_without_characters;
			}
		}
		return closedFunction.toReturn;
	}

	var testselector = MySelectorActionClassOptionalConstrParams();
	testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;
	//testselector._possible_tiles_to_choose_function = all_active_characters();
	testselector._numberOfTilesToSelect = 1;

	var selectorActionCharacter = MySelectorActionClass(all_active_characters(), testselector);
	var selectorActionWithoutCharacter = MySelectorActionClass(all_empty_tile_in_distance());
	var selectorActionWithoutCharacter2 = MySelectorActionClass(all_empty_tile_in_distance());

	var testselector4 = MySelectorActionClassOptionalConstrParams();
	testselector4._numberOfTilesToSelect = 3;
	testselector4._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;

	var selectorActionWithoutCharacter3 = MySelectorActionClass(all_empty_tile_in_distance(3), testselector4);


	var mySelectorActionList = ds_list_create();

	ds_list_add(mySelectorActionList, selectorActionCharacter);
	ds_list_add(mySelectorActionList, selectorActionWithoutCharacter);
	ds_list_add(mySelectorActionList, selectorActionWithoutCharacter2);
	ds_list_add(mySelectorActionList, selectorActionWithoutCharacter3);
	
	var seleManager = MySelectorActionManagerClass(mySelectorActionList);
	seleManager.start(self)

	return seleManager;
}

