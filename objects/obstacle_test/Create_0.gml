event_inherited();
properties_layer_base_depth = global.LAYERS.decoration.depth;
//properties_layer_base_depth = properties_layer_base_depth + (2 * global.LAYERS.ground.depth_period) + 10

self.properties_bg_sprite = bg_desert_terrain_2_ground; // Przypisz sprite tła

// Losowe odbicie w poziomie
//image_xscale = choose(1, -1); // 1 = brak odbicia, -1 = odbicie lustrzane
// Losowe odbicie w pionie
//image_yscale = choose(1, -1); // 1 = brak odbicia, -1 = odbicie lustrzane

after_create_event();