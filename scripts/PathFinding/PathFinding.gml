// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

//function get_direction_to_nearest_enemy(startRow, startCol) {
//	var max_rows = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.__rows - 1;
//	var max_cols = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.__cols - 1;
	
//	var hex_directions = [
//    [ 1,  0], [ 1, -1], [ 0, -1],
//    [-1,  0], [-1,  1], [ 0,  1]
//];
	
//    var visitedMap = ds_map_create();
//    var searchQueue = ds_queue_create();
    
//    ds_queue_enqueue(searchQueue, [startRow, startCol, -1, -1]);
//    ds_map_add(visitedMap, string(startRow) + "," + string(startCol), true);
    
//    while (ds_queue_size(searchQueue) > 0) {
//        var currentNode = ds_queue_dequeue(searchQueue);
//        var currentRow = currentNode[0];
//        var currentCol = currentNode[1];
//        var fromRow = currentNode[2];
//        var fromCol = currentNode[3];
        
//        if ( global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(currentRow, currentCol).has_character() && 
//			isEnemy(currentRow, currentCol)) {
//            // cofamy się do poprzedniego pola aż do startu
//            while (fromRow != startRow || fromCol != startCol) {
//                currentRow = fromRow;
//                currentCol = fromCol;

//                var key = string(currentRow) + "," + string(currentCol);
//                var fromNode = visitedMap[? key];
//                fromRow = fromNode[0];
//                fromCol = fromNode[1];
//            }

//            ds_map_destroy(visitedMap);
//            ds_queue_destroy(searchQueue);
//            return [currentRow - startRow, currentCol - startCol];
//        }

//        for (var i = 0; i < 6; i++) {
//            var dir = hex_directions[i];
//            var neighborRow = currentRow + dir[1];
//            var neighborCol = currentCol + dir[0];
//            var key = string(neighborRow) + "," + string(neighborCol);

//            // sprawdzenie granic i czy można tam wejść
//            if (neighborRow >= 0 && neighborRow < max_rows &&
//                neighborCol >= 0 && neighborCol < max_cols &&
//                !ds_map_exists(visitedMap, key) /* &&
//                is_walkable(neighborRow, neighborCol) */) {

//                ds_map_add(visitedMap, key, [currentRow, currentCol]);
//                ds_queue_enqueue(searchQueue, [neighborRow, neighborCol, currentRow, currentCol]);
//            }
//        }
//    }

//    ds_map_destroy(visitedMap);
//    ds_queue_destroy(searchQueue);
    
//    return undefined; // brak ścieżki
//}





function get_target_tile_to_nearest_enemy(source_Char, startRow, startCol) {
	var max_rows = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.__rows;
	var max_cols = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.__cols;
	
	// Even-q offset — zależnie od kolumny
var hex_directions_even = [
    [-1, -1], // góra-lewo (7)
    [-1,  0], // góra-prawo (9)
    [ 0, -1], // lewo (4)
    [ 0,  1], // prawo (6)
    [ 1, -1], // dół-lewo (1)
    [ 1,  0]  // dół-prawo (3)
];
var hex_directions_odd = [
    [-1,  0], // góra-lewo (7)
    [-1,  1], // góra-prawo (9)
    [ 0, -1], // lewo (4)
    [ 0,  1], // prawo (6)
    [ 1,  0], // dół-lewo (1)
    [ 1,  1]  // dół-prawo (3)
];
	var visitedMap = ds_map_create();
	var searchQueue = ds_queue_create();
	
	ds_queue_enqueue(searchQueue, [startRow, startCol, -1, -1]);
	ds_map_add(visitedMap, string(startRow) + "," + string(startCol), true);
	
	while (ds_queue_size(searchQueue) > 0) {
		var currentNode = ds_queue_dequeue(searchQueue);
		var currentRow = currentNode[0];
		var currentCol = currentNode[1];
		var fromRow = currentNode[2];
		var fromCol = currentNode[3];
		
		if (global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(currentRow, currentCol).has_character() &&
			isEnemy(source_Char, currentRow, currentCol)) {
				
			while (fromRow != startRow || fromCol != startCol) {
				currentRow = fromRow;
				currentCol = fromCol;

				var key = string(currentRow) + "," + string(currentCol);
				var fromNode = visitedMap[? key];
				fromRow = fromNode[0];
				fromCol = fromNode[1];
			}

			ds_map_destroy(visitedMap);
			ds_queue_destroy(searchQueue);
			return [currentRow, currentCol];
		}

		var directions = (currentRow mod 2 == 0) ? hex_directions_even : hex_directions_odd;

		for (var i = 0; i < 6; i++) {
		    var dir = directions[i];
		    var neighborRow = currentRow + dir[0];
		    var neighborCol = currentCol + dir[1];
		    var key = string(neighborRow) + "," + string(neighborCol);

		    if (neighborRow >= 0 && neighborRow < max_rows &&
		        neighborCol >= 0 && neighborCol < max_cols &&
		        !ds_map_exists(visitedMap, key) &&
	               isWalkable(neighborRow, neighborCol)) {

		        ds_map_add(visitedMap, key, [currentRow, currentCol]);
		        ds_queue_enqueue(searchQueue, [neighborRow, neighborCol, currentRow, currentCol]);
		    }
		}
	}
	
	ds_map_destroy(visitedMap);
	ds_queue_destroy(searchQueue);
	
	return undefined; // nie znaleziono ścieżki
}


function isWalkable(arg_row, arg_col) {
	var destTile = global.COMBAT_GLOBALS.MAP
		.MAP_HOLDER.get_tile(arg_row, arg_col);

	return destTile.is_walkable();
}

/// @param {Id.Instance<Id.Instance.AbstTurnEntity>}
function isEnemy(source_Char, currentRow, currentCol) {
	var destTile = global.COMBAT_GLOBALS.MAP
		.MAP_HOLDER.get_tile(currentRow, currentCol);

	return destTile.hasTurnEntity() && 
		destTile.getTurnEntityStruct().getFaction() != getTurnEntityStruct(source_Char).getFaction()
			// destTile.__character.my_character_side != source_Char.my_character_side
}