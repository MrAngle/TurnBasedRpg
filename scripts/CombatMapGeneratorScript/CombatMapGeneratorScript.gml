function combat_map_generator_generate_random_desert_map(rows, cols) {
	var _map = MyCombatMapHolder(rows, cols);
	
	randomize();
	for (var row = 0; row < rows; row++) {
	    for (var col = 0; col < cols; col++) {
			//var chosen_object = choose(desert_2_ground, desert_3_ground, grass_1_ground);
			var chosen_object = choose(desert_2_ground, grass_1_ground);
			
			var tile = instance_create_layer(0, 0, global.LAYERS.ground.id, chosen_object);
			_map.get_tile(row, col).set_tile_auto_type(tile);
			
			tile.visible = false; // ukryj pole
	    }
	}
	
	return _map;
}
