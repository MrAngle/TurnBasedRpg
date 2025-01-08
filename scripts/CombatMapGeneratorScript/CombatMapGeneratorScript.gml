function combat_map_generator_generate_random_desert_map(rows, cols) {
	var _map = MyCombatMapHolder(rows, cols);
	
	for (var row = 0; row < rows; row++) {
	    for (var col = 0; col < cols; col++) {
			var tile = instance_create_layer(0, 0, global.LAYERS_GROUND, Desert1Empty);
			_map.get_tile(row, col).set_tile_auto_type(tile);
			
			tile.visible = false; // ukryj pole
	    }
	}
	
	return _map;
}
