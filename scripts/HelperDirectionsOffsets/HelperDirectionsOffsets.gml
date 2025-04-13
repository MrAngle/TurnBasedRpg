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

//global.DIRECTION_OFFSETS = {
//    [DirectionId.LEFT]: function(row, col) {
//        return [0, -1];
//    },
//    [DirectionId.RIGHT]: function(row, col) {
//        return [0, 1];
//    },
//    [DirectionId.UP_LEFT]: function(row, col) {
//        return [-1, row % 2 == 0 ? -1 : 0];
//    },
//    [DirectionId.UP_RIGHT]: function(row, col) {
//        return [-1, row % 2 == 0 ? 0 : 1];
//    },
//    [DirectionId.DOWN_LEFT]: function(row, col) {
//        return [1, row % 2 == 0 ? -1 : 0];
//    },
//    [DirectionId.DOWN_RIGHT]: function(row, col) {
//        return [1, row % 2 == 0 ? 0 : 1];
//    }
//};


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