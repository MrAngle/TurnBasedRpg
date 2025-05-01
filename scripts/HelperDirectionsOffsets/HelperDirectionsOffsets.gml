enum DirectionId {
	LEFT,
	RIGHT,
	UP_LEFT,
	UP_RIGHT,
	DOWN_LEFT,
	DOWN_RIGHT
}

/// @returns {Array<Real>}
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

function getDirectionBetweenTiles(fromRow, fromCol, toRow, toCol) {
    var directions = [
        DirectionId.LEFT,
        DirectionId.RIGHT,
        DirectionId.UP_LEFT,
        DirectionId.UP_RIGHT,
        DirectionId.DOWN_LEFT,
        DirectionId.DOWN_RIGHT
    ];

    for (var i = 0; i < array_length(directions); i++) {
        var dir = directions[i];
        var pos = helper_calculate_row_and_col_for_direction(dir, fromRow, fromCol);
        if (pos[0] == toRow && pos[1] == toCol) {
            return dir;
        }
    }
    return undefined;
}

function getOppositeDirection(direction) {
    switch (direction) {
        case DirectionId.LEFT: return DirectionId.RIGHT;
        case DirectionId.RIGHT: return DirectionId.LEFT;
        case DirectionId.UP_LEFT: return DirectionId.DOWN_RIGHT;
        case DirectionId.UP_RIGHT: return DirectionId.DOWN_LEFT;
        case DirectionId.DOWN_LEFT: return DirectionId.UP_RIGHT;
        case DirectionId.DOWN_RIGHT: return DirectionId.UP_LEFT;
        default: return undefined;
    }
}


