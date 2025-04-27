// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function AutoActionScripts() 
{

}

function autoActionResolveIntent(character) {
	var row = character.getRow();
	var col = character.getCol()

	var tile = get_target_tile_to_nearest_enemy(character, row, col);
	if (is_undefined(tile)) {
		return ACTION_INTENT_ENUM.STAND;
	}

	var target_row = tile[0];
	var target_col = tile[1];

	var dir = get_direction_towards_position(row, col, target_row, target_col);

	if (dir != noone) {
		return global.ENUM_MAPPERS.directionIdToActionIntentId(dir);
	}

	return ACTION_INTENT_ENUM.STAND;
}



function get_direction_towards_position(from_row, from_col, to_row, to_col) {
	var row_diff = to_row - from_row;
	var col_diff = to_col - from_col;

	// Porównujemy przesunięcia z możliwymi kierunkami
	for (var dir = 0; dir < 6; dir++) { // Zakładamy 6 kierunków
		var offset = helper_get_direction_offset(dir, from_row);
		if (offset[0] == row_diff && offset[1] == col_diff) {
			return dir; // zwraca DirectionId
		}
	}

	return noone; // brak dopasowania
}