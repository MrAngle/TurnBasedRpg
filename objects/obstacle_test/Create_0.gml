event_inherited();
properties_layer_base_depth = global.LAYERS.obstacles.depth;
//properties_layer_base_depth = properties_layer_base_depth + (2 * global.LAYERS.ground.depth_period) + 10

self.properties_bg_sprite = bg_desert_terrain_2_ground; // Przypisz sprite tła

sprite_index = choose(ruins_1_obstacle, stone_3_obstacle, stone_2_obstacle, stone_1_obstacle, barrel_1_obstacle);
// Losowe odbicie w poziomie
//image_xscale = choose(1, -1); // 1 = brak odbicia, -1 = odbicie lustrzane
// Losowe odbicie w pionie
//image_yscale = choose(1, -1); // 1 = brak odbicia, -1 = odbicie lustrzane

after_create_event();