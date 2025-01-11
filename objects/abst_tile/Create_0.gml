// DRAW PROPERTIES
my_obj_name = global.myGlobalObjName_None

// on mouse enter
//my_mouse_enter_function = global.MY_EMPTY_FUNCTION;

// Properties
properties_load_layer();
properties_load_map_element();
properties_load_after_create_event();


__abst_tile_after_create = function() {
	layer_set_depth(properties_layer_base_depth);
	
	after_create_executed = true;
}

