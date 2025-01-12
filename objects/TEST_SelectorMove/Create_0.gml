show_debug_message("START - INIT TEST_SelectorMove");

startTest = false;
frame_period = 10;

alarm[0] = global.ALARM_PERIOD_MINIMUM;

global.____INIT_DEFAULT_MANAGER = function() {
	init_layers();
	instance_create_layer(0, 0, global.LAYERS.managers.id, DebuggerInstance);
	instance_create_layer(0, 0, global.LAYERS.game_cursor.id, cursor_obj_game);
	instance_create_layer(0, 0, global.LAYERS.managers.id, SelectorManager);

	combatMapHolder = combat_map_generator_generate_random_desert_map(8, 13);
	combatMapManager = MyCombatMapManager(combatMapHolder);

	global.myCombatMapHolder = combatMapHolder;
	global.myCombatMapManager = combatMapManager;

	menuCharsTurnManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuManager);


	global.myCombatMapHolder.show_tiles();

	var character = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);
	var character2 = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);

	global.myCombatMapHolder.get_tile(5, 5).set_tile_auto_type(character);
	global.myCombatMapHolder.get_tile(3, 10).set_tile_auto_type(character2);


	combatCharactersHolderClass = CombatCharactersHolderClass(global.myCombatMapManager.get_all_characters_on_map())
	global.myCombatCharactersHolderClass = combatCharactersHolderClass;
	combatTurnManager = instance_create_layer(0, 0, global.LAYERS.managers.id, CombatTurnManager);
	global.myCombatTurnManager = combatTurnManager;

	instance_create_layer(0, 0, global.LAYERS.selectors.id, TileSelector);

	my_start_combat = function() {
		combatTurnManager.switch_to_player_turn();
	}
	my_start_combat();
}


alarm[1] = global.ALARM_PERIOD_MINIMUM + 120;
show_debug_message("FINISH - INIT TEST_SelectorMove");
