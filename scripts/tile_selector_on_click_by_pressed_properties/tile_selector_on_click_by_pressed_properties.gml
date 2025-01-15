
//global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) { // Remember to pass reference
//	show_debug_message("tile_selector_on_click_element is not set for object: " + string(_self.id));
//}

//global.TILE_SELECTOR_SELECTED_TILES = 

function properties_load_tile_selector_on_select_by_pressed() 
{
	properties_is_tile_selector_on_click_element = true;
	
	tile_selector_on_click_event = function(_self) {
		return global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION(_self);
	}
	//tile_selector_on_click_event = global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION;
}