// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function CombatMapGeneratorFlood() 
{

}

function flood_fill_accessible_tiles(map, startRow, startCol) {
	var max_rows = map.__rows;
	var max_cols = map.__cols;
	
	var visited = ds_map_create();
	var queue = ds_queue_create();
	
	var start_key = string(startRow) + "," + string(startCol);
	ds_queue_enqueue(queue, [startRow, startCol]);
	ds_map_add(visited, start_key, true);
	
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

	while (ds_queue_size(queue) > 0) {
		var current = ds_queue_dequeue(queue);
		var row = current[0];
		var col = current[1];

		var directions = (row mod 2 == 0) ? hex_directions_even : hex_directions_odd;

		for (var i = 0; i < 6; i++) {
			var dir = directions[i];
			var nRow = row + dir[0];
			var nCol = col + dir[1];
			var key = string(nRow) + "," + string(nCol);

			if (nRow >= 0 && nRow < max_rows &&
				nCol >= 0 && nCol < max_cols &&
				!ds_map_exists(visited, key)) {

				var tile = map.get_tile(nRow, nCol);
				if (tile != undefined && tile.is_walkable()) {
					ds_map_add(visited, key, true);
					ds_queue_enqueue(queue, [nRow, nCol]);
				}
			}
		}
	}

	return visited; // mapa kluczy do wszystkich dostępnych pól
}

function get_path_with_cleanup(map, startRow, startCol, endRow, endCol, max_repair_attempts) {
	for (var attempt = 0; attempt <= max_repair_attempts; attempt++) {
		var path = get_path_from_to(map, startRow, startCol, endRow, endCol);
		if (path != undefined) {
			return path;
		}

		// brak ścieżki — usuń losową przeszkodę (która NIE jest startem/cielem)
		var removed = false;

		for (var r = 0; r < map.__rows && !removed; r++) {
			for (var c = 0; c < map.__cols && !removed; c++) {
				if ((r != startRow || c != startCol) && (r != endRow || c != endCol)) {
					var tile = map.get_tile(r, c);
					if (tile.__obstacle != noone) {
						with (tile.__obstacle) instance_destroy();
						tile.__obstacle = noone;
						removed = true;
					}
				}
			}
		}
	}

	return undefined; // mimo prób – nadal nie znaleziono
}


function combat_map_generator_generate_connected_desert_map(rows, cols) {
	var _map = MyCombatMapHolder(rows, cols);
randomize();
	// 1. Wstępne generowanie z przeszkodami
	for (var row = 0; row < rows; row++) {
		for (var col = 0; col < cols; col++) {
			var tile_type;
			
			// Pole startowe zawsze bez przeszkody
			if (row == 0 && col == 0) {
				tile_type = choose(desert_2_ground, grass_1_ground);
			} else {
				var roll = irandom_range(0, 100);
				if (roll < 25) {
					tile_type = obstacle_test; // przeszkoda
				} else {
					tile_type = choose(desert_2_ground, grass_1_ground);
				}
			}

			var tile = instance_create_layer(0, 0, global.LAYERS.ground.id, tile_type);
			var selectedTile = _map.get_tile(row, col);
			selectedTile.set_tile_auto_type(tile);
			tile.visible = false;
		}
	}
	
	var path = get_path_with_cleanup(_map,5, 6, rows - 1, cols - 1, 50);
if (path == undefined) {
    return combat_map_generator_generate_connected_desert_map(rows, cols); // restart
}


ensure_map_connectivity(_map, 5, 5);
	return _map;
}

function ensure_map_connectivity(map, startRow, startCol) {
	var max_rows = map.__rows;
	var max_cols = map.__cols;

	var changed = true;
	while (changed) {
		changed = false;

		// 1. Flood fill od startu
		var reachable = flood_fill_accessible_tiles(map, startRow, startCol);

		// 2. Szukaj nieosiągalnych pól
		for (var row = 0; row < max_rows; row++) {
			for (var col = 0; col < max_cols; col++) {
				var tile = map.get_tile(row, col);
				if (tile.is_walkable()) {
					var key = string(row) + "," + string(col);
					if (!ds_map_exists(reachable, key)) {
						// Znajdź najbliższą przeszkodę do usunięcia (losowo)
						var fixed = false;

						for (var i = 0; i < 6; i++) {
							var neighbors = get_hex_neighbors(row, col);
							for (var n = 0; n < array_length(neighbors); n++) {
								var nr = neighbors[n][0];
								var nc = neighbors[n][1];

								if (nr >= 0 && nr < max_rows &&
									nc >= 0 && nc < max_cols) {
									var ntile = map.get_tile(nr, nc);
									if (ntile.__obstacle != noone) {
										with (ntile.__obstacle) instance_destroy();
										ntile.__obstacle = noone;
										fixed = true;
										changed = true;
										break;
									}
								}
							}
							if (fixed) break;
						}
					}
				}
			}
		}

		ds_map_destroy(reachable);
	}
}

function get_hex_neighbors(row, col) {
	var directions_even = [
		[-1, -1], [-1,  0],
		[ 0, -1], [ 0,  1],
		[ 1, -1], [ 1,  0]
	];
	var directions_odd = [
		[-1,  0], [-1,  1],
		[ 0, -1], [ 0,  1],
		[ 1,  0], [ 1,  1]
	];

	var dirs = (row mod 2 == 0) ? directions_even : directions_odd;
	var result = [];
	for (var i = 0; i < 6; i++) {
		array_push(result, [row + dirs[i][0], col + dirs[i][1]]);
	}
	return result;
}

