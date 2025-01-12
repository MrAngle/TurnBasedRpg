//enum SelectorState {
//    Idle,
//    TileSelected,
//    UnitSelected
//}

instance_create_layer(0, 0, global.LAYERS.selectors.id, HexHoverFieldDecoration);
instance_create_layer(0, 0, global.LAYERS.selectors.id, HexActiveFieldDecoration);

properties_selector_active_tile = noone; // MyMapTile
properties_selector_active_character = noone; // MyMapTile

properties_selector_selected_tiles = [];
properties_selector_selected_units = [];

// conditions
// 1. properties_selector_active_character and is player character
// 2. max 1 properties_selector_selected_tiles and properties_selector_selected_units = []

//selector_state_select_reset()
//selector_state_select_player()
//selector_state_select_empty_tile()

checkCondition = true;

properties_selector_selected_tiles = noone;
	//SelectorTilesHolderClass(3, SELECTOR_TYPE_ENUM.SELECTED, SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX);
properties_selector_active_tiles = noone;
	//SelectorTilesHolderClass(1, SELECTOR_TYPE_ENUM.ACTIVE, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);

//global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) {
//	var _MyMapTile = __get_map_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

//	properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);

//	global.mySelectedCharacter = _MyMapTile.__character;
//}



//__init_select_character = function(_self) {
//	properties_selector_selected_tiles = 
//		SelectorTilesHolderClass(1, SELECTOR_TYPE_ENUM.SELECTED, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);
	
//	global.TILE_SELECTOR_EVENT_ON_CLICK = __select_character;
//}





selector_select_character = function(_numberOfCharacters) {
	//properties_selector_active_tiles = 
	//	SelectorTilesHolderClass(_numberOfCharacters, SELECTOR_TYPE_ENUM.ACTIVE, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);

	closedFunction = {
		closedNumberOfCharacters: _numberOfCharacters,
		tilesPossibleToSelect: function(_self, _) {
		},
		toReturn: function(_self, closed_properties_selector_selected_tiles) {
			var _MyMapTile = global.myCombatMapHolder.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

			if(_MyMapTile.has_character() /*&& !closed_properties_selector_selected_tiles.contains_tile(_MyMapTile) */) {
				closed_properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
			}
		
			//if(closed_properties_selector_selected_tiles.get_size() >= closedNumberOfCharacters) {
			//	return true;
			//}
		
			//return false;
		}
	}
	return closedFunction.toReturn;
}

selector_select_tile_without_characters = function(_numberOfTilesToSelect) {
	//properties_selector_selected_tiles = 
	//	SelectorTilesHolderClass(_numberOfTilesToSelect, SELECTOR_TYPE_ENUM.SELECTED, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);

	closedFunction = {
		closed_numberOfTilesToSelect: _numberOfTilesToSelect,
		//closed_properties_selector_selected_tiles: properties_selector_selected_tiles,
		toReturn: function(_self, closed_properties_selector_selected_tiles) {
			var _MyMapTile = global.myCombatMapHolder.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

			if(!_MyMapTile.has_character()) {
				closed_properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
			}
		
			//if(closed_properties_selector_selected_tiles.get_size() >= closed_numberOfTilesToSelect) {
			//	return true;
			//}
		
			//return false;
		}
	}
	return closedFunction.toReturn;
}

var testselector = MySelectorActionClassOptionalConstrParams();
testselector._SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.ACTIVE;

var selectorActionCharacter = MySelectorActionClass(selector_select_character(1), testselector);
var selectorActionWithoutCharacter = MySelectorActionClass(selector_select_tile_without_characters(1), testselector);

var mySelectorActionList = ds_list_create();

ds_list_add(mySelectorActionList, selectorActionCharacter);
ds_list_add(mySelectorActionList, selectorActionWithoutCharacter);

selectorActionManager = MySelectorActionManagerClass(mySelectorActionList);

//_move = MyActionClass(selector_select_character(1), 
//			MyActionClass(selector_select_tile_without_characters(1), undefined))

global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) {
	selectorActionManager.execute(_self);
}

//MyActionClass(selector_select_character(1, , 
//MyActionClass(selectTile, undefined))




//__select_character = function(_self) {
//	var _MyMapTile = __get_map_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

//	if(_MyMapTile.has_character()) {
//		properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
//	}
	

//	global.mySelectedCharacter = _MyMapTile.__character;
//	global.TILE_SELECTOR_EVENT_ON_CLICK = __select_empty_tile;
//}

//__select_empty_tile = function(_nextFunc) {
	
//}

//__init_select_character(self);



__selector_state_select_reset = function() {
	properties_selector_active_tile = noone; // MyMapTile
	properties_selector_active_character = noone; // MyMapTile

	properties_selector_selected_tiles = [];
	properties_selector_selected_units = [];
}


__get_map_tile = function(_row_index, _col_index) {
	return global.myCombatMapHolder.get_tile(_row_index, _col_index);

	//var selectedTile = global.myCombatMapHolder.get_tile(_row_index, _col_index);
	//if(selectedTile != global.mySelectedTile) {
	//	global.mySelectedTile = selectedTile;
		
	//	if(global.mySelectedCharacter == noone) {
	//		global.mySelectedCharacter = selectedTile.__character;
	//	}
		
	//} else {
	//	global.mySelectedTile = noone;
	//	global.mySelectedCharacter = noone;
	//}
}



//global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) {

//	if(_self.properties_is_map_element != noone && _self.properties_is_map_element == true) {
//		__select_map_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);
//	}
//}




//requirements = [
//    {name: "Select player character", check: function() {
        
//    }},
//    {name: "Active Character is Player", check: function() {
//        return properties_selector_active_character.is_player;
//    }},
//    {name: "Max 1 Selected Tile", check: function() {
//        return array_length(properties_selector_selected_tiles) <= 1 && array_length(properties_selector_selected_units) == 0;
//    }}
//];




//selector_select_character = function(_numberOfCharacters) {
//	properties_selector_active_tiles = 
//		SelectorTilesHolderClass(_numberOfCharacters, SELECTOR_TYPE_ENUM.ACTIVE, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);

//	closedFunction = {
//		closedNumberOfCharacters: _numberOfCharacters,
//		closedproperties_selector_active_tiles: properties_selector_active_tiles,
//		toReturn: function(_self) {
//			var _MyMapTile = global.myCombatMapHolder.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

//			if(_MyMapTile.has_character()) {
//				closedproperties_selector_active_tiles.add_tile_MyMapTile(_MyMapTile);
//			}
		
//			if(closedproperties_selector_active_tiles.get_size() >= closedNumberOfCharacters) {
//				return true;
//			}
		
//			return false;
//		}
//	}
//	return closedFunction.toReturn;
//}


//selector_select_tile_without_characters = function(_numberOfTilesToSelect) {
//	properties_selector_selected_tiles = 
//		SelectorTilesHolderClass(_numberOfTilesToSelect, SELECTOR_TYPE_ENUM.SELECTED, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);

//	closedFunction = {
//		closed_numberOfTilesToSelect: _numberOfTilesToSelect,
//		closed_properties_selector_selected_tiles: properties_selector_selected_tiles,
//		toReturn: function(_self) {
//			var _MyMapTile = global.myCombatMapHolder.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

//			if(!_MyMapTile.has_character()) {
//				closed_properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
//			}
		
//			if(closed_properties_selector_selected_tiles.get_size() >= closed_numberOfTilesToSelect) {
//				return true;
//			}
		
//			return false;
//		}
//	}
//	return closedFunction.toReturn;
//}