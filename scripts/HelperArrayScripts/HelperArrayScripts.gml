// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function helper_array_destroy_objects(arg_instance_array) 
{
	for (var i = 0; i < array_length(arg_instance_array); i++) {
	    if (!helper_object_is_undefined_or_empty(arg_instance_array[i]) && instance_exists(arg_instance_array[i])) { // Sprawdzamy, czy instancja nadal istnieje
	        instance_destroy(arg_instance_array[i]); // Usuwamy instancję
	    }
	}
}


function helper_array_tiles_to_characters(struct_array) {
    // Tworzymy nową tablicę
    var character_array = [];
    
    // Iterujemy przez tablicę struktur
    for (var i = 0; i < array_length(struct_array); i++) {
        var struct_instance = struct_array[i];
        
        // Sprawdzamy, czy struct zawiera pole __character
        if (is_struct(struct_instance) && variable_struct_exists(struct_instance, "__character")) {
            // Dodajemy wartość pola __character do nowej tablicy
            array_push(character_array, struct_instance.__character);
        }
    }
    
    return character_array; // Zwracamy nową tablicę
}
