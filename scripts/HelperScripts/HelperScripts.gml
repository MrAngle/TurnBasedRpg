

function helper_has_property_true(_data, property_name) {
	if (helper_is_struct(_data)) {
        if (variable_struct_exists(_data, property_name)) {
            //return _data[? property_name] == true; // Zwracamy wartość pola, jeśli istnieje
			return variable_struct_get(_data, property_name) == true;
        }
    } else if (helper_is_object(_data)) {
        if (variable_instance_exists(_data, property_name)) {
			
			return variable_struct_get(_data, property_name) == true;
            //return _data[? property_name] == true; // Zwracamy wartość pola, jeśli istnieje
        }
    }
    // Pole nie istnieje lub nie jest struct/obiektem
    return false;
}

function helper_is_struct(_data) {
	if (typeof(_data) == global.TYPEOF_STRUCT) {
        return true;
    }

    return false;
}

function helper_is_object(_data) {
    // Sprawdzamy, czy zmienna jest typu "object"
    if (typeof(_data) == global.TYPEOF_OBJECT) {
        // Sprawdzamy, czy instancja obiektu istnieje
        // return instance_exists(_data); // w razie potrzeby odkomentowac - niewydajne jest sprawdzanie
		
		return true;
    }

    return false;
}

function helper_is_boolean(variable) {
    return (variable == true || variable == false);
}

function helper_create_undefined_array(_size) {
    var arr = array_create(_size); // Tworzy tablicę
    for (var i = 0; i < _size; i++) {
        arr[i] = undefined; // Wypełnia wartością `undefined`
    }
    return arr;
}

function helper_is_not_definied(_obj) {
	if(_obj == undefined || _obj == noone) {
		return true;
	}
	return false;
}

function helper_is_definied(_obj) {
	if(_obj == undefined || _obj == noone) {
		return false;
	}
	return true;
}


function helper_array_is_undefined_or_empty(arrayToCheck) {
	return arrayToCheck == undefined || array_length(arrayToCheck) == 0;
}

function helper_array_length_safe(arrayToCheck) {
    if (arrayToCheck == undefined) {
        return 0; // Tablica jest undefined, więc traktujemy ją jako pustą
    }
    return array_length(arrayToCheck); // Zwracamy rzeczywisty rozmiar tablicy
}

function helper_function_is_undefined_or_noone(functionToCheck) {
	return functionToCheck == undefined || functionToCheck == noone;
}

function helper_object_is_undefined_or_empty(objectToCheck) {
	return objectToCheck == undefined || objectToCheck == noone || !instance_exists(objectToCheck);
}

function helper_object_not_exists(objectToCheck) {
	return helper_object_is_undefined_or_empty(objectToCheck);
	//return objectToCheck == undefined || objectToCheck == noone || !instance_exists(objectToCheck);
}

function helper_object_exists(objectToCheck) {
	return objectToCheck != undefined && objectToCheck != noone && instance_exists(objectToCheck);
}

function helper_struct_is_undefined_or_empty(structToCheck) {
	return structToCheck == undefined || structToCheck == noone;
}

function helper_string_parse_to_name(object_name) {
    // Zmienna wyjściowa
    var result = "";

    // Sprawdź, czy nazwa zawiera podkreślenia "_"
    if (string_pos("_", object_name) > 0) {
        // Zamień "_" na spacje
        result = string_replace_all(object_name, "_", " ");
    } else {
        // Jeśli brak podkreśleń, pozostaw nazwę bez zmian
        result = object_name;
    }

    // Zamień pierwszą literę na dużą
    result = string_upper(string_copy(result, 1, 1)) + string_delete(result, 1, 1);

    // Zwróć przetworzoną nazwę
    return result;
}