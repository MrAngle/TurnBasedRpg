
global.TILE_SELECTOR_EVENT_ON_CLICK = function(_self) { // Remember to pass reference
	show_debug_message("tile_selector_on_click_element is not set for object: " + string(id));
}

global.TILE_SELECTOR_SELECTED_TILES = 

function properties_load_tile_selector_on_select_by_pressed() 
{
	properties_is_tile_selector_on_click_element = true;
	
	tile_selector_on_click_event = global.TILE_SELECTOR_EVENT_ON_CLICK;
}