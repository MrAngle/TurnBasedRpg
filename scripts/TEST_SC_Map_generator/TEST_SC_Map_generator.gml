// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function TEST_SC_Map_generator_30x30() 
{
	global.__INIT_COMBAT_MAP_HOLER = function() {
		global.COMBAT_GLOBALS.MAP.MAP_HOLDER = combat_map_generator_generate_random_desert_map(30, 30);
	}
	global.___LOAD_CHARACTERS_ACTIONS = function() {
	}
	
	testActionsManager = TEST_actionsManager();
	testActionsManager.add(helper_simulate_click_at_index_function(0, 0))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 4))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 3))
	testActionsManager.add(helper_simulate_click_at_index_function(6, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(5, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(29, 29))
	
	return testActionsManager;
	
}

function TEST_SC_Map_generator(_width, _height) 
{
	closedFunction = {
		_arg_width: _width,
		_arg_height: _height,
		toReturn: function() {
			global.__INIT_COMBAT_MAP_HOLER = function() {
				global.COMBAT_GLOBALS.MAP.MAP_HOLDER = combat_map_generator_generate_random_desert_map(_arg_width, _arg_height);
			}
			global.___LOAD_CHARACTERS_ACTIONS = function() {
			}
	
			testActionsManager = TEST_actionsManager();
			//testActionsManager.add(helper_simulate_click_at_index_function(0, 0))
			//testActionsManager.add(helper_simulate_click_at_index_function(_arg_width - 1, _arg_height - 1))
			
			return testActionsManager;
		}
	}
	
	
	return closedFunction.toReturn;
	
	//return testActionsManager;
	
}


function TEST_SC_Map_generator_100x100() 
{
	global.__INIT_COMBAT_MAP_HOLER = function() {
		global.COMBAT_GLOBALS.MAP.MAP_HOLDER = combat_map_generator_generate_random_desert_map(100, 100);
	}
	global.___LOAD_CHARACTERS_ACTIONS = function() {
	}
	
	testActionsManager = TEST_actionsManager();
	testActionsManager.add(helper_simulate_click_at_index_function(5, 5))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 4))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 3))
	testActionsManager.add(helper_simulate_click_at_index_function(6, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(5, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(99, 99))
	//testActionsManager.add(helper_simulate_click_at_index_function(100, 100))
	
	return testActionsManager;
	
}


//function TEST_SC_SelectorAction_chain() 
//{
//	global.___LOAD_CHARACTERS_ACTIONS = function() {
//		var character = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);
//		var character2 = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);

//		global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(5, 5).set_tile_auto_type(character);
//		global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(3, 10).set_tile_auto_type(character2);
//	}
	
//	testActionsManager = TEST_actionsManager();
//	testActionsManager.add(helper_simulate_click_at_index_function(5, 5))
//	testActionsManager.add(helper_simulate_click_at_index_function(3, 4))
//	testActionsManager.add(helper_simulate_click_at_index_function(3, 3))
//	testActionsManager.add(helper_simulate_click_at_index_function(6, 2))
//	testActionsManager.add(helper_simulate_click_at_index_function(5, 2))
//	testActionsManager.add(helper_simulate_click_at_index_function(5, 2))
//	testActionsManager.add(helper_check_if_char_in_tile(3, 4, ObjNecro1));
	
//	return testActionsManager;
//}