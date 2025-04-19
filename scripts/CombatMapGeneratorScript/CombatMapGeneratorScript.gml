//function combat_map_generator_generate_random_desert_map(rows, cols) {
//	var _map = MyCombatMapHolder(rows, cols);
	
//	randomize();
//	for (var row = 0; row < rows; row++) {
//	    for (var col = 0; col < cols; col++) {
//			//var chosen_object = choose(desert_2_ground, desert_3_ground, grass_1_ground);
//			var chosen_object = choose(desert_2_ground, grass_1_ground, obstacle_test);
			
//			var tile = instance_create_layer(0, 0, global.LAYERS.ground.id, chosen_object);
//			_map.get_tile(row, col).set_tile_auto_type(tile);
			
//			tile.visible = false; // ukryj pole
//	    }
//	}
	
//	return _map;
//}



function combat_map_generator_generate_random_desert_map(rows, cols) {
	var _map = new MyCombatMapHolderBuilder(rows, cols);
randomize();
	// 1. Wygeneruj mapę z samą ziemią
	for (var row = 0; row < rows; row++) {
		for (var col = 0; col < cols; col++) {
			var tile = instance_create_layer(0, 0, global.LAYERS.ground.id, choose(desert_2_ground, grass_1_ground));
			_map.get_tile(row, col).set_tile_auto_type(tile);
			tile.visible = false;
		}
	}

	// 2. Wybierz punkt start i cel
	var start = [0, 0];
	var goal = [rows - 1, cols - 1];

	// 3. Znajdź ścieżkę (np. funkcją get_path_from_to(startRow, startCol, goalRow, goalCol))
	var path = get_path_from_to(_map, start[0], start[1], goal[0], goal[1]);

	// Jeśli nie ma ścieżki — restartuj generowanie
	if (path == undefined) {
		return combat_map_generator_generate_random_desert_map(rows, cols); // restart
	}

	// 4. Zablokuj część pól, ale NIE tych należących do ścieżki
	for (var row = 0; row < rows; row++) {
		for (var col = 0; col < cols; col++) {
			var is_path = false;

			// Sprawdź, czy to pole jest częścią ścieżki
			for (var i = 0; i < array_length(path); i++) {
				if (path[i][0] == row && path[i][1] == col) {
					is_path = true;
					break;
				}
			}

			// Zablokuj z pewnym prawdopodobieństwem tylko pola spoza ścieżki
			if (!is_path && irandom_range(0, 100) < 60) { // 25% szansa na przeszkodę
				var tile = _map.get_tile(row, col);
				tile.set_tile_auto_type(instance_create_layer(0, 0, global.LAYERS.ground.id, obstacle_test));
				tile.visible = false;
				tile.walkable = false;
			}
		}
	}

	return _map;
}

function get_path_from_to(map, startRow, startCol, endRow, endCol) {
	var max_rows = map.__rows;
	var max_cols = map.__cols;

	var hex_directions_even = [
		[-1, -1], [-1,  0],
		[ 0, -1], [ 0,  1],
		[ 1, -1], [ 1,  0]
	];

	var hex_directions_odd = [
		[-1,  0], [-1,  1],
		[ 0, -1], [ 0,  1],
		[ 1,  0], [ 1,  1]
	];

	var visited = ds_map_create();
	var queue = ds_queue_create();
	var came_from = ds_map_create();

	var start_key = string(startRow) + "," + string(startCol);
	ds_queue_enqueue(queue, [startRow, startCol]);
	ds_map_add(visited, start_key, true);
	ds_map_add(came_from, start_key, undefined);

	while (ds_queue_size(queue) > 0) {
		var current = ds_queue_dequeue(queue);
		var row = current[0];
		var col = current[1];

		if (row == endRow && col == endCol) {
			// dotarliśmy — składamy ścieżkę
			var path = [];
			var key = string(row) + "," + string(col);

			while (key != start_key) {
				var parts = string_split(key, ",");
				var r = real(parts[0]);
				var c = real(parts[1]);
				array_insert(path, 0, [r, c]);

				key = came_from[? key];
			}
			array_insert(path, 0, [startRow, startCol]);

			ds_map_destroy(visited);
			ds_map_destroy(came_from);
			ds_queue_destroy(queue);
			return path;
		}

		var directions = (row mod 2 == 0) ? hex_directions_even : hex_directions_odd;

		for (var i = 0; i < 6; i++) {
			var dir = directions[i];
			var neighborRow = row + dir[0];
			var neighborCol = col + dir[1];
			var neighbor_key = string(neighborRow) + "," + string(neighborCol);

			if (neighborRow >= 0 && neighborRow < max_rows &&
				neighborCol >= 0 && neighborCol < max_cols &&
				!ds_map_exists(visited, neighbor_key)) {

				var tile = map.get_tile(neighborRow, neighborCol);
				if (tile != undefined && tile.__obstacle == noone) {
					ds_map_add(visited, neighbor_key, true);
					ds_map_add(came_from, neighbor_key, string(row) + "," + string(col));
					ds_queue_enqueue(queue, [neighborRow, neighborCol]);
				}
			}
		}
	}

	ds_map_destroy(visited);
	ds_map_destroy(came_from);
	ds_queue_destroy(queue);
	return undefined; // brak ścieżki
}

