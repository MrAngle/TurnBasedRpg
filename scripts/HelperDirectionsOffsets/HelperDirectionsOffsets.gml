// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

enum DirectionId {
	LEFT,
	RIGHT,
	UP_LEFT,
	UP_RIGHT,
	DOWN_LEFT,
	DOWN_RIGHT
}

function helper_calculate_row_and_col_for_direction(arg_DirectionId, row, col) {
	var offset = helper_get_direction_offset(arg_DirectionId, row);
	return [row + offset[0], col + offset[1]];
}

function helper_get_direction_offset(arg_DirectionId, row) {
	switch (arg_DirectionId) {
		case DirectionId.LEFT:        return [0, -1];
		case DirectionId.RIGHT:       return [0, 1];
		case DirectionId.UP_LEFT:     return [-1, (row % 2 == 0) ? -1 : 0];
		case DirectionId.UP_RIGHT:    return [-1, (row % 2 == 0) ? 0 : 1];
		case DirectionId.DOWN_LEFT:   return [1, (row % 2 == 0) ? -1 : 0];
		case DirectionId.DOWN_RIGHT:  return [1, (row % 2 == 0) ? 0 : 1];
		default:                      return [0, 0]; // fallback
	}
}

/// @param {Id.Instance.abst_tile} sourceObj
/// @param {Struct.MyMapTile} targetTile
/// @returns {Struct.MyMapTile}
function getTileBehindTargetTile(sourceObj, targetTile) {
    // Pozycje
    var invokerRow = sourceObj. properties_map_element_row_index;
    var invokerCol = sourceObj.properties_map_element_col_index;
    
    var targetRow = targetObj.row;
    var targetCol = targetObj.col;
    
    // 1. Ustalamy kierunek od targeta do invokera
    var directionToInvoker = helper_get_direction_from_target_to_invoker(targetRow, targetCol, invokerRow, invokerCol);
    
    if (directionToInvoker == undefined) {
        return undefined; // brak bezpośredniego sąsiedztwa
    }
    
    // 2. Bierzemy przeciwny kierunek
    var oppositeDirection = helper_get_opposite_direction(directionToInvoker);
    
    // 3. Obliczamy nowy kafel w przeciwnym kierunku
    var behindPos = helper_calculate_row_and_col_for_direction(oppositeDirection, targetRow, targetCol);
    
    return behindPos; // [row, col]
}