// DRAW PROPERTIES
my_obj_name = global.myGlobalObjName_None

// draw border
my_draw_border_color = c_white;
my_draw_border_radius = global.__map_tile_radius;
my_draw_border_thickness = 3;

// on mouse enter
my_mouse_enter_function = global.MY_EMPTY_FUNCTION;

// LAYERS properties
//properties_layer_base_depth = 0;

// Properties
properties_load_layer();
properties_load_map_element();
properties_load_after_create_event();

//__layer_set_depth = function(_depth) {
//	self.depth = _depth;
//}

__abst_tile_after_create = function() {
	layer_set_depth(properties_layer_base_depth);
	
	after_create_executed = true;
}

