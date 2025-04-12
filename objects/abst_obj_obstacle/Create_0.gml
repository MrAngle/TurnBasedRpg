event_inherited();
properties_layer_base_depth = global.LAYERS.obstacles.depth;

properties_map_element_obj_type = MapElementObjectTypeEnum.OBSTACLE;
//my_obj_name = global.myGlobalObjName_Terrain; // nazwa obiektu

properties_border_decoration_default_color = c_white;

properties_load_background_decoration();

after_create_event = function() {
	if (!after_create_executed) {
		__abst_obj_terrain_after_create();
		__abst_tile_after_create();
		
		self.image_xscale = choose(1, -1); // 1 = brak odbicia, -1 = odbicie lustrzane
	}

	after_create_executed = true;
} // should be as last action of create event of every child

layer_set_depth = function(_depth) {
	__layer_set_depth(_depth);
	__abst_obj_terrain_set_depth(_depth);
}

map_element_set_x = function(_x) {
    __map_element_set_x(_x);
    __abst_obj_terrain_set_x(_x);
}

map_element_set_y = function(_y) {
    __map_element_set_y(_y);
    __abst_obj_terrain_set_y(_y);
}

// IMPL ABST
__abst_obj_terrain_set_depth = function(_depth) {
	properties_bg_set_depth(_depth);
}

__abst_obj_terrain_set_x = function(_x) {
    if (properties_bg_instance != noone) {
        properties_bg_instance.x = _x;
    }
};

__abst_obj_terrain_set_y = function(_y) {
    if (properties_bg_instance != noone) {
        properties_bg_instance.y = _y;
    }
};

__abst_obj_terrain_after_create = function() {
	
	properties_bg_print();
    //if (my_bg_sprite != noone) {
    //    my_bg_instance = instance_create_layer(x, y, global.LAYERS.ground.id, my_bg_sprite);
    //    my_bg_instance.sprite_index = my_bg_sprite;
    //}
};
