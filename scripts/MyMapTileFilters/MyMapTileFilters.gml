// ALL FILTERS SHOULD HAVE STRUCTURE:
// FUNCTION(MyMapTile) - return true or false (when true it mean that pass filter)

// SUPPORTED FILTERS
function mapTile_filter_element_is_in_array(_arrayToCheck) {
	//return helper_function_element_is_in_array(_arrayToCheck);
	closedFunction = {
		filterFunc: helper_function_element_is_in_array(_arrayToCheck)
	}
	return closedFunction;
}

function mapTile_filter_element_is_not_in_array(_arrayToCheck) {
	closedFunction = {
		filterFunc: helper_function_element_is_not_in_array(_arrayToCheck)
	}
	return closedFunction;
	//return helper_function_element_is_not_in_array(_arrayToCheck);
}

function mapTile_filter_element_contains_character() {
	closedFunction = {
		filterFunc: function(_myMapTileObjectToCheck) {
			return !helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character);
	    }
	}
	return closedFunction;
}

//function mapTile_filter_element_contains_character() {
//	closedFunction = {
//		toReturn: function(_myMapTileObjectToCheck) {
//			return !helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character);
//	    }
//	}
//	return closedFunction;
//}

function mapTile_filter_element_NOT_contains_character() {
	closedFunction = {
		filterFunc: function(_myMapTileObjectToCheck) {
			return helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character);
	    }
	}
	return closedFunction;
}

//function mapTile_filter_within_distance(_myMapTileSource, _distance) {
//    closedFunction = {
//        __source_row: _myMapTileSource._properties_map_element_row_index,
//        __source_col: _myMapTileSource._properties_map_element_col_index,
//        __distance: _distance,
//        filterFunc: function(_myMapTileObjectToCheck) {
//            // Obliczamy różnice między wierszami i kolumnami
//            var row_diff = abs(_myMapTileObjectToCheck._properties_map_element_row_index - self.__source_row);
//            var col_diff = abs(_myMapTileObjectToCheck._properties_map_element_col_index - self.__source_col);

//            // Sprawdzamy, czy kafelek znajduje się w odległości manhattańskiej <= __distance
//            return (row_diff + col_diff) <= self.__distance;
//        }
//    };
//    return closedFunction;
//}

function mapTile_filter_within_distance(_myMapTileSource, _distance) {
    closedFunction = {
        __source_row: _myMapTileSource._properties_map_element_row_index,
        __source_col: _myMapTileSource._properties_map_element_col_index,
        __distance: _distance,
        filterFunc: function(_myMapTileObjectToCheck) {
            // Przekształcenie współrzędnych źródła na axial
            var source_axial = offset_to_axial(self.__source_row, self.__source_col);
            var source_q = source_axial[0];
            var source_r = source_axial[1];

            // Przekształcenie współrzędnych sprawdzanego kafelka na axial
            var check_axial = offset_to_axial(
                _myMapTileObjectToCheck._properties_map_element_row_index,
                _myMapTileObjectToCheck._properties_map_element_col_index
            );
            var check_q = check_axial[0];
            var check_r = check_axial[1];

            // Obliczenie odległości heksagonalnej
            var q_diff = abs(check_q - source_q);
            var r_diff = abs(check_r - source_r);
            var s_diff = abs((-check_q - check_r) - (-source_q - source_r));

            var hex_distance = max(q_diff, r_diff, s_diff);

            // Sprawdzamy, czy kafelek znajduje się w zadanej odległości
            return hex_distance <= self.__distance;
        }
    };
    return closedFunction;
}


// Przekształcenie współrzędnych offset (row, col) na axial (q, r)
function offset_to_axial(row, col) {
    var q = col - floor(row / 2); // Kolumny przesunięte w zależności od rzędu
    var r = row;                 // Rzędy pozostają takie same
    return [q, r];
}

//function offset_to_axial(row, col) {
//    var q = col - ceil(row / 2); // Kolumny przesunięte w zależności od rzędu
//    var r = row;                 // Rzędy pozostają takie same
//    return [q, r];
//}

//function mapTile_filter_element_contains_character() {
//	closedFunction = {
//		toReturn: function(_objectToCheck) {
//			return helper_array_is_contain_element(_arrayToCheck, _objectToCheck);
//	    }
//	}
//	return closedFunction.toReturn;
//}

//function helper_function_element_is_not_in_array(_arrayToCheck) {
//	closedFunction = {
//		__arrayToCheck: _arrayToCheck,
//		toReturn: function(_objectToCheck) {
//			return !helper_array_is_contain_element(__arrayToCheck, _objectToCheck);
//	    }
//	}
//	return closedFunction.toReturn;
//}
