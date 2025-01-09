event_inherited();

my_base_depth = my_base_depth + 2 * global.LAYERS_GROUND_DEPTH_PERIOD


my_bg_sprite = bg_desert_terrain_2_ground; // Przypisz sprite tła
//var background_instance = instance_create_layer(x, y, global.LAYER_GROUND, my_bg_sprite);
//background_instance.sprite_index = my_bg_sprite;


//my_bg_sprite.depth = my_base_depth - 1;

my_terrain_after_create();
my_abst_after_create();