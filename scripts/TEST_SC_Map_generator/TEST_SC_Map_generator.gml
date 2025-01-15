// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
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
			testActionsManager.add(helper_simulate_click_at_index_function(0, 0))
			testActionsManager.add(helper_simulate_click_at_index_function(_arg_width - 1, _arg_height - 1))
			
			return testActionsManager;
		}
	}
	
	
	return closedFunction.toReturn;
}