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


__selector_state_select_reset = function() {
	properties_selector_active_tile = noone; // MyMapTile
	properties_selector_active_character = noone; // MyMapTile

	properties_selector_selected_tiles = [];
	properties_selector_selected_units = [];
}


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

