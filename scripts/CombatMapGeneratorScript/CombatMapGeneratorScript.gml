function combat_map_generator_generate_random_desert_map(rows, cols) {
	var _map = MyCombatMapHolder(rows, cols);
	
	for (var row = 0; row < rows; row++) {
	    for (var col = 0; col < cols; col++) {
	        // Oblicz pozycję X i Y dla każdego heksagonu
	        //var pos_x = col * global.__map_tile_width + ((row % 2) * (global.__map_tile_width / 2)); // Przesunięcie co drugi wiersz
	        //var pos_y = row * (1.5 * global.__map_tile_radius);
        
			var tile = instance_create_layer(0, 0, global.LAYERS_GROUND, desert_1_empty);

			//_map.set_tile(tile, TileObjectTypeEnum.TERRAIN);
			//my_map_set_tile(row, col, tile);
			
			_map.get_tile(row, col).set_tile(tile, TileObjectTypeEnum.TERRAIN);
			
			tile.visible = false; // ukryj pole
		
			// Przypisz kolumnę i wiersz do heksagonu
	        //tile._init_col = col;
	        //tile._init_row = row;
	    }
	}
	
	return _map;
}



//function combat_map_generator_generate_random_desert_map(rows, cols) {
//	var _map = MyCombatMapHolder(rows, cols);
	
//	for (var row = 0; row < rows; row++) {
//	    for (var col = 0; col < cols; col++) {
//	        // Oblicz pozycję X i Y dla każdego heksagonu
//	        var pos_x = col * global.__map_tile_width + ((row % 2) * (global.__map_tile_width / 2)); // Przesunięcie co drugi wiersz
//	        var pos_y = row * (1.5 * global.__map_tile_radius);
        
//			var tile = instance_create_layer(pos_x + global.__map_tile_width, pos_y + global.__map_tile_height, global.LAYERS_GROUND, desert_1_empty);

//			_map.set_tile(row, col, tile);
//			//my_map_set_tile(row, col, tile);
//			tile.visible = false; // ukryj pole
		
//			// Przypisz kolumnę i wiersz do heksagonu
//	        tile._init_col = col;
//	        tile._init_row = row;
//	    }
//	}
	
//	return _map;
//}