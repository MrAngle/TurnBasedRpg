image_alpha = 0;
//mask_index = -1;
properties_load_map_element(self);
//properties_load_on_click_element();
properties_load_border_decoration();
properties_load_layer();
properties_load_on_mouse_enter();
properties_load_tile_selector_on_select_by_pressed();

properties_layer_base_depth = global.LAYERS.selectors.depth;

on_mouse_enter_func = function() {
	global.COMBAT_GLOBALS.MAP.HOVERED_TILE = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(
		self.getRow(), 
		self.getCol()
	);
	//global.COMBAT_GLOBALS.MAP.HOVERED_TILE.__terrain.properties_border_decoration_default_color = c_ltgrey;
}