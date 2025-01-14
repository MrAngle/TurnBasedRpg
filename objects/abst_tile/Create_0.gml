// DRAW PROPERTIES
my_obj_name = helper_string_parse_to_name(object_get_name(object_index));

//global.myGlobalObjName_None

var object_name = object_get_name(object_index);
show_debug_message("Nazwa obiektu: " + object_name);

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

