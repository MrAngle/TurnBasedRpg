// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function TEST_SC_SelectorAction_chain() 
{
	global.___LOAD_CHARACTERS_ACTIONS = function() {
		var character = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);
		var character2 = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);

		global.myCombatMapHolder.get_tile(5, 5).set_tile_auto_type(character);
		global.myCombatMapHolder.get_tile(3, 10).set_tile_auto_type(character2);
	}
	
	testActionsManager = TEST_actionsManager();
	testActionsManager.add(helper_simulate_click_at_index_function(5, 5))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 4))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 3))
	testActionsManager.add(helper_simulate_click_at_index_function(6, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(5, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(5, 2))
	testActionsManager.add(helper_check_if_char_in_tile(3, 4, ObjNecro1));
	
	return testActionsManager;
}

function TEST_SC_SelectorAction_chain_cancel() 
{
	global.___LOAD_CHARACTERS_ACTIONS = function() {
		var character = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);
		var character2 = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);

		global.myCombatMapHolder.get_tile(5, 5).set_tile_auto_type(character);
		global.myCombatMapHolder.get_tile(3, 10).set_tile_auto_type(character2);
	}
	
	testActionsManager = TEST_actionsManager();
	testActionsManager.add(helper_simulate_click_at_index_function(5, 5))
	testActionsManager.add(helper_simulate_key_press_escape_function())
	//MISS
	testActionsManager.add(helper_simulate_click_at_index_function(7, 8))
	testActionsManager.add(helper_simulate_click_at_index_function(7, 9))
	
	testActionsManager.add(helper_simulate_click_at_index_function(5, 5))
	testActionsManager.add(helper_simulate_click_at_index_function(5, 4))
	testActionsManager.add(helper_simulate_key_press_escape_function())
	testActionsManager.add(helper_simulate_key_press_escape_function())
	testActionsManager.add(helper_simulate_click_at_index_function(5, 5))
	testActionsManager.add(helper_simulate_click_at_index_function(5, 4))
	testActionsManager.add(helper_simulate_click_at_index_function(5, 4))
	testActionsManager.add(helper_simulate_key_press_escape_function())
	testActionsManager.add(helper_simulate_key_press_escape_function())
	
	//MISS
	testActionsManager.add(helper_simulate_click_at_index_function(7, 8))
	testActionsManager.add(helper_simulate_click_at_index_function(7, 9))
	
	testActionsManager.add(helper_simulate_key_press_escape_function())
	
	testActionsManager.add(helper_check_if_char_in_tile(5, 5, ObjNecro1));
	
	
	testActionsManager.add(helper_simulate_click_at_index_function(5, 5))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 4))
	testActionsManager.add(helper_simulate_key_press_escape_function())
	testActionsManager.add(helper_simulate_click_at_index_function(3, 3))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 4))
	testActionsManager.add(helper_simulate_click_at_index_function(3, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(4, 3))
	testActionsManager.add(helper_simulate_click_at_index_function(4, 2))
	testActionsManager.add(helper_simulate_click_at_index_function(4, 3))
	
	//MISS
	testActionsManager.add(helper_simulate_click_at_index_function(7, 8))
	
	testActionsManager.add(helper_check_if_char_in_tile(3, 4, ObjNecro1));
	
	return testActionsManager;
}