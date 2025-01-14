// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function INIT_CombatManager() 
{
	global.____INIT_DEFAULT_MANAGER();
}

//global.____INIT_DEFAULT_MANAGER = function() {
//	init_layers();
//	instance_create_layer(0, 0, global.LAYERS.managers.id, DebuggerInstance);
//	instance_create_layer(0, 0, global.LAYERS.game_cursor.id, cursor_obj_game);
//	instance_create_layer(0, 0, global.LAYERS.managers.id, SelectorManager);

//	combatMapHolder = combat_map_generator_generate_random_desert_map(8, 13);
//	combatMapManager = MyCombatMapManager(combatMapHolder);

//	global.COMBAT_GLOBALS.MAP.MAP_HOLDER = combatMapHolder;
//	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP = combatMapManager;

//	menuCharsTurnManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuManager);


//	global.COMBAT_GLOBALS.MAP.MAP_HOLDER.show_tiles();

//	var character = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);
//	var character2 = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);

//	global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(5, 5).set_tile_auto_type(character);
//	global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(3, 5).set_tile_auto_type(character2);


//	combatCharactersHolderClass = CombatCharactersHolderClass(global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.get_all_characters_on_map())
//	global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER = combatCharactersHolderClass;
//	combatTurnManager = instance_create_layer(0, 0, global.LAYERS.managers.id, CombatTurnManager);
//	global.COMBAT_GLOBALS.MANAGERS.COMBAT_TURN = combatTurnManager;

//	instance_create_layer(0, 0, global.LAYERS.selectors.id, TileSelector);

//	my_start_combat = function() {
//		combatTurnManager.switch_to_player_turn();
//	}
//	my_start_combat();
//}


global.____STATIC_LOAD_MANAGER = function() {
	
	global.___INIT_MANAGER();

	global.___LOAD_CHARACTERS_ACTIONS();
	
	global.___AFTER_CREATE_MANAGER()
}

global.__INIT_COMBAT_MAP_HOLER = function() {
	global.COMBAT_GLOBALS.MAP.MAP_HOLDER = combat_map_generator_generate_random_desert_map(8, 13);
}

global.___INIT_MANAGER = function() {
	global.__INIT_COMBAT_GLOBAL();
	init_layers();

	instance_create_layer(0, 0, global.LAYERS.managers.id, DebuggerInstance);
	instance_create_layer(0, 0, global.LAYERS.game_cursor.id, cursor_obj_game);
	global.COMBAT_GLOBALS.MANAGERS.SELECTOR = instance_create_layer(0, 0, global.LAYERS.managers.id, SelectorManager);

	global.__INIT_COMBAT_MAP_HOLER();
	//global.COMBAT_GLOBALS.MAP.MAP_HOLDER = combat_map_generator_generate_random_desert_map(8, 13);
	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP = MyCombatMapManager(global.COMBAT_GLOBALS.MAP.MAP_HOLDER);
	global.myMenuManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuManager);
}

global.___LOAD_CHARACTERS_ACTIONS = function() {
	var character = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);
	var character2 = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);

	global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(5, 5).set_tile_auto_type(character);
	global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(3, 10).set_tile_auto_type(character2);
}

global.___AFTER_CREATE_MANAGER = function() {
	global.COMBAT_GLOBALS.MAP.MAP_HOLDER.show_tiles();
	combatCharactersHolderClass = CombatCharactersHolderClass(global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.get_all_characters_on_map())
	global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER = combatCharactersHolderClass;
	combatTurnManager = instance_create_layer(0, 0, global.LAYERS.managers.id, CombatTurnManager);
	global.COMBAT_GLOBALS.MANAGERS.COMBAT_TURN = combatTurnManager;

	instance_create_layer(0, 0, global.LAYERS.selectors.id, TileSelector);

	my_start_combat = function() {
		combatTurnManager.switch_to_player_turn();
	}
	my_start_combat();
}