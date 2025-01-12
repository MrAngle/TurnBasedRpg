

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

function helper_create_undefined_array(_size) {
    var arr = array_create(_size); // Tworzy tablicę
    for (var i = 0; i < _size; i++) {
        arr[i] = undefined; // Wypełnia wartością `undefined`
    }
    return arr;
}

function helper_is_empty(_obj) {
	if(_obj == undefined || _obj == noone) {
		return true;
	}
	return false;
}