//for (var i = 0; i < array_length(instance_array); i++) {
//    if (instance_exists(instance_array[i])) { // Sprawdzamy, czy instancja nadal istnieje
//        instance_destroy(instance_array[i]); // Usuwamy instancję
//    }
//}

helper_array_destroy_objects(__actions_to_select)
__actions_to_select = [];

// Opcjonalne: Wyczyść tablicę, jeśli już jej nie potrzebujesz
//instance_array = [];