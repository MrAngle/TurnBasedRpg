function helper_function_element_is_in_array(_arrayToCheck) {
	closedFunction = {
		__arrayToCheck: _arrayToCheck,
		toReturn: function(_objectToCheck) {
			return helper_array_is_contain_element(__arrayToCheck, _objectToCheck);
	    }
	}
	return closedFunction.toReturn;
}

function helper_function_element_is_not_in_array(_arrayToCheck) {
	closedFunction = {
		__arrayToCheck: _arrayToCheck,
		toReturn: function(_objectToCheck) {
			return !helper_array_is_contain_element(__arrayToCheck, _objectToCheck);
	    }
	}
	return closedFunction.toReturn;
}

function helper_array_is_contain_element(_arrayToCheck, _objectToCheck) {
    for (var i = 0; i < array_length(_arrayToCheck); i++) {
        if (_arrayToCheck[i] == _objectToCheck) {
            return true; // Obiekt jest w tablicy
        }
    }
    return false; // Obiekt nie jest w tablicy
}