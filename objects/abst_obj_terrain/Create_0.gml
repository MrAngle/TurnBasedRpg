event_inherited();
my_base_depth = global.GROUND_DEPTH;

my_hex_obj_type = TileObjectTypeEnum.TERRAIN;
my_obj_name = global.myGlobalObjName_Terrain; // nazwa obiektu

my_draw_border_color = c_white;

my_bg_sprite = noone;
my_bg_instance = noone;

my_terrain_after_create = function() {
	if(my_bg_sprite != noone) {
		my_bg_instance = instance_create_layer(x, y, global.LAYER_GROUND, my_bg_sprite);
		my_bg_instance.sprite_index = my_bg_sprite;
		my_bg_instance.depth = my_base_depth + 1;
	}
}
