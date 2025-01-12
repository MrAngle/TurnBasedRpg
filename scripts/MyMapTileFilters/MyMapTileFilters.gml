// ALL FILTERS SHOULD HAVE STRUCTURE:
// FUNCTION(MyMapTile) - return true or false (when true it mean that pass filter)

// SUPPORTED FILTERS
function mapTile_filter_element_is_in_array(_arrayToCheck) {
	return helper_function_element_is_in_array(_arrayToCheck);
}

function mapTile_filter_element_is_not_in_array(_arrayToCheck) {
	return helper_function_element_is_not_in_array(_arrayToCheck);
}

function mapTile_filter_element_contains_character() {
	closedFunction = {
		toReturn: function(_myMapTileObjectToCheck) {
			return !helper_object_is_undefined_or_empty(_myMapTileObjectToCheck.__character);
	    }
	}
	return closedFunction.toReturn;
}


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
