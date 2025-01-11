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

properties_selector_selected_tiles = 
	SelectorTilesHolderClass(2, SELECTOR_TYPE_ENUM.SELECTED, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);
properties_selector_active_tiles = 
	SelectorTilesHolderClass(1, SELECTOR_TYPE_ENUM.ACTIVE, SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX);

global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) {
	var _MyMapTile = __get_map_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

	properties_selector_selected_tiles.add_tile_MyMapTile(_MyMapTile);
}



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

