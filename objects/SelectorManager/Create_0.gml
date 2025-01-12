instance_create_layer(0, 0, global.LAYERS.selectors.id, HexHoverFieldDecoration);
instance_create_layer(0, 0, global.LAYERS.selectors.id, HexActiveFieldDecoration);

checkCondition = true;

//selector_select_character = function(_numberOfCharacters) {
//	closedFunction = {
//		closedNumberOfCharacters: _numberOfCharacters,
//		toReturn: function(_self, closed_properties_selector_selected_tiles) {
//			var _MyMapTile = global.myCombatMapHolder.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

//			if(_MyMapTile.has_character() /*&& !closed_properties_selector_selected_tiles.contains_tile(_MyMapTile) */) {
//				closed_properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
//			}
//		}
//	}
//	return closedFunction.toReturn;
//}

//selector_select_tile_without_characters = function(_numberOfTilesToSelect) {
//	closedFunction = {
//		closed_numberOfTilesToSelect: _numberOfTilesToSelect,
//		//closed_properties_selector_selected_tiles: properties_selector_selected_tiles,
//		toReturn: function(_self, closed_properties_selector_selected_tiles) {
//			var _MyMapTile = global.myCombatMapHolder.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

//			if(!_MyMapTile.has_character()) {
//				closed_properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
//			}
//		}
//	}
//	return closedFunction.toReturn;
//}

//all_active_characters = function() {
//	closedFunction = {
//		toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
//			var notIncludeThisTilesFunc = mapTile_filter_element_is_not_in_array(__result_SelectorTilesHolderClass.get_all_myMapTiles());
//			var containsCharacter = mapTile_filter_element_contains_character();
//			//var notIncludeThisTilesFunc = helper_object_is_undefined_or_empty(__result_SelectorTilesHolderClass.get_all_myMapTiles());
//		    var tiles_with_characters = global.myCombatMapHolder.get_tiles_with_characters([notIncludeThisTilesFunc, containsCharacter]);
			
//			return tiles_with_characters;
//		}
//	}
//	return closedFunction.toReturn;
//}

//all_empty_tile = function() {
//	closedFunction = {
//		toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
//			var tilesWithoutCharactersFunc = mapTile_filter_element_NOT_contains_character();
//		    var tiles_without_characters = global.myCombatMapHolder.get_tiles_with_characters([tilesWithoutCharactersFunc]);
			
//			return tiles_without_characters;
//		}
//	}
//	return closedFunction.toReturn;
//}

//all_empty_tile_in_distance = function() {
//	closedFunction = {
//		toReturn: function(_self, __result_SelectorTilesHolderClass, __previous_result_SelectorTilesHolderClass) {
//			var tilesWithoutCharactersFunc = mapTile_filter_element_NOT_contains_character();
//			var tilesInDistance = mapTile_filter_within_distance(__previous_result_SelectorTilesHolderClass.get_all_myMapTiles()[0], 2);
//		    var tiles_without_characters = global.myCombatMapHolder.get_tiles_with_characters([tilesWithoutCharactersFunc, tilesInDistance]);
			
//			return tiles_without_characters;
//		}
//	}
//	return closedFunction.toReturn;
//}

//var testselector = MySelectorActionClassOptionalConstrParams();
//testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;
//testselector._possible_tiles_to_choose_function = all_active_characters();
//testselector._numberOfTilesToSelect = 2;

//var selectorActionCharacter = MySelectorActionClass(selector_select_character(2), testselector);

//var testselector2 = MySelectorActionClassOptionalConstrParams();
//testselector2._possible_tiles_to_choose_function = all_empty_tile_in_distance();

//var selectorActionWithoutCharacter = MySelectorActionClass(selector_select_tile_without_characters(1), testselector2);

//var mySelectorActionList = ds_list_create();

//ds_list_add(mySelectorActionList, selectorActionCharacter);
//ds_list_add(mySelectorActionList, selectorActionWithoutCharacter);

//selectorActionManager = MySelectorActionManagerClass(mySelectorActionList);

selectorActionManager = getMySelectorActionManagerClass();
alarm[0] = global.ALARM_PERIOD_MINIMUM;

global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) {
	selectorActionManager.execute(_self);
}

__selector_state_select_reset = function() {
	properties_selector_active_tile = noone; // MyMapTile
	properties_selector_active_character = noone; // MyMapTile

	properties_selector_selected_tiles = [];
	properties_selector_selected_units = [];
}


__get_map_tile = function(_row_index, _col_index) {
	return global.myCombatMapHolder.get_tile(_row_index, _col_index);
}
