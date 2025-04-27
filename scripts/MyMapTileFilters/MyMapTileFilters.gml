// ALL FILTERS SHOULD HAVE STRUCTURE:
// FUNCTION(MyMapTile) - return true or false (when true it mean that pass filter)

/// @constructor
/// @struct
/// @property {function(Struct.MyMapTile): boolean} _filterFunc
/// @returns {Struct.MapTileFilter}
function MapTileFilter(_filterFunc) constructor {
    filterFunc = _filterFunc;
}


// SUPPORTED FILTERS
function mapTile_filter_element_is_in_array(_arrayToCheck) {
	//return helper_function_element_is_in_array(_arrayToCheck);
	var closedFunction = {
		filterFunc: helper_function_element_is_in_array(_arrayToCheck)
	}
	return closedFunction;
}

function mapTile_filter_element_is_not_in_array(_arrayToCheck) {
	var closedFunction = {
		filterFunc: helper_function_element_is_not_in_array(_arrayToCheck)
	}
	return closedFunction;
	//return helper_function_element_is_not_in_array(_arrayToCheck);
}

function mapTile_filter_element_contains_character() {
	var closedFunction = {
		filterFunc: function(_myMapTileObjectToCheck) {
			return !helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character);
	    }
	}
	return closedFunction;
}


function mapTile_filter_element_contains_player_character() {
	var closedFunction = {
		/// @param {Struct.MyMapTile} _myMapTileObjectToCheck
		filterFunc: function(_myMapTileObjectToCheck) {
			if(_myMapTileObjectToCheck.hasTurnEntity()) {
				return _myMapTileObjectToCheck.getTurnEntityStruct().getFaction() == FACTION_ENUM.PLAYER
			}
	    }
	}
	return closedFunction;
}

/// @returns {Struct.MapTileFilter}
function mapTile_filter_element_contains_turn_entity() {
	var closedFunction = {
		/// @param {Struct.MyMapTile} _myMapTileObjectToCheck
		filterFunc: function(_myMapTileObjectToCheck) {
			return _myMapTileObjectToCheck.hasTurnEntity();
	    }
	}
	return closedFunction;
}


// function mapTile_filter_element_contains_character_and_can_perform_action() {
// 	var closedFunction = {
// 		filterFunc: function(_myMapTileObjectToCheck) {
// 			if(helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character)) {
// 				return false;
// 			}
			
// 			//return !_myMapTileObjectToCheck.__character.prepare_turn_is_prepared_for_turn();
// 			//return _myMapTileObjectToCheck.__character.__properties_action_can_perform;
// 			//return _myMapTileObjectToCheck.__character.__properties_action_is_prepared_for_turn;
// 	    }
// 	}
// 	return closedFunction;
// }

function mapTile_filter_element_contains_character_and_is_NOT_prepared_for_turn() {
	var closedFunction = {
		filterFunc: function(_myMapTileObjectToCheck) {
			if(helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character)) {
				return false;
			}
			
			//return !(_myMapTileObjectToCheck.__character.__properties_action_is_prepared_for_turn);
			return !(_myMapTileObjectToCheck.__character.prepare_turn_is_prepared_for_turn());
	    }
	}
	return closedFunction;
}

function mapTile_filter_element_NOT_contains_character() {
	var closedFunction = {
		filterFunc: function(_myMapTileObjectToCheck) {
			return helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character);
	    }
	}
	return closedFunction;
}

/// @param {Struct.MyMapTile} _myMapTileSource
function mapTile_filter_within_distance(_myMapTileSource, _distance) {
    var closedFunction = {
        __source_row: _myMapTileSource.getRow(),
        __source_col: _myMapTileSource.getCol(),
        __distance: _distance,
        filterFunc: function(_myMapTileObjectToCheck) {
            // Przekształcenie współrzędnych źródła na axial
            var source_axial = offset_to_axial(self.__source_row, self.__source_col);
            var source_q = source_axial[0];
            var source_r = source_axial[1];

            // Przekształcenie współrzędnych sprawdzanego kafelka na axial
            var check_axial = offset_to_axial(
                _myMapTileObjectToCheck.getRow(),
                _myMapTileObjectToCheck.getCol()
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

