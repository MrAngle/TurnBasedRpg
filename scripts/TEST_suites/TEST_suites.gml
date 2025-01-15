// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377


global.TEST_DEFAULT_SCENARIO_DELAY = 20;
global.TEST_FINISH_SCENARIO = true; // TO STOP SCENARIO
function GET_NEXT_TEST_SCENAIO() {
    var SUITES = {
        SELECTOR: [
			TEST_SC_SelectorAction_chain, 
			TEST_SC_SelectorAction_chain_cancel
		],
		MAP: [
			TEST_SC_Map_generator(5, 5),
			TEST_SC_Map_generator(10, 10),
			TEST_SC_Map_generator(20, 30),
			TEST_SC_Map_generator(10, 20),
			TEST_SC_Map_generator(40, 40),
			TEST_SC_Map_generator(100, 100)
		],
		
		get_by_index: function(index) {
		    var current_index = 0;
		    var keys = variable_struct_get_names(self); // Pobierz klucze
		    for (var i = 0; i < array_length(keys); i++) {
		        var key = keys[i];
		        if (key == "get_by_index") continue; // Pomijamy metodę

		        // Pobierz wartość pod kluczem
		        var value = variable_struct_get(self, key);
		        if (is_array(value)) {
		            if (index < current_index + array_length(value)) {
		                return value[index - current_index];
		            }
		            current_index += array_length(value);
		        }
		    }
			global.GAME_GLOBALS.TEST.FINISHED = true;
		    helper_room_move_to_previous_room(); // Jeśli indeks wykracza poza zakres
		}
    };
	
	return SUITES.get_by_index(global.GAME_GLOBALS.TEST.SCENARIO_INDEX);
};
