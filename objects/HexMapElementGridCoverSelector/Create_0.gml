image_alpha = 0;

properties_load_map_element();
properties_load_on_click_element();
properties_load_border_decoration();
properties_load_layer();
properties_load_on_mouse_enter();

properties_layer_base_depth = global.LAYERS.selectors.depth;

on_mouse_enter_func = function() {
	global.myActiveHoveredTile = global.myCombatMapHolder.get_tile(
		self.properties_map_element_row_index, 
		self.properties_map_element_col_index
	);
	//global.myActiveHoveredTile.__terrain.properties_border_decoration_default_color = c_ltgrey;
}