//[players, enemies, neutrals];
//trunCombatCharacters = global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER;

//combatCharactersHolderClass = CombatCharactersHolderClass(global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.get_all_characters_on_map())
//global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER = combatCharactersHolderClass;

properties_turn_init_action_selector = noone;
properties_active_turn_character = noone; // abst_combat_character
properties_character_to_prepare_actions = noone; // abst_combat_character


__set_character_to_prepare_actions = function(arg_character) {
	properties_character_to_prepare_actions = arg_character;
	
	global.COMBAT_GLOBALS.MANAGERS.ACTION_SELECTOR = instance_create_layer(0, 0, global.LAYERS.managers.id, PrepareActionsSelectorManager);
	global.COMBAT_GLOBALS.MANAGERS.ACTION_SELECTOR.properties_character_to_prepare_actions = properties_character_to_prepare_actions;
}




enum TURN_PHASE_ENUM {
	INIT_PREPARE_TURN,
	PREPARE_TURN,
	CHARACTER_ACTION_EXECUTION
}

__currentPhaseEnum = TURN_PHASE_ENUM.INIT_PREPARE_TURN;


__prepare_turn_characters = noone;
__init_prepare_turn = function() {
	var containsCharacterNotPrepared = mapTile_filter_element_contains_character_and_is_NOT_prepared_for_turn();
	//var notIncludeThisTilesFunc = helper_object_is_undefined_or_empty(__result_SelectorTilesHolderClass.get_all_myMapTiles_as_array());
	var tiles_with_characters = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([containsCharacterNotPrepared]);
	__prepare_turn_characters = helper_array_tiles_to_characters(tiles_with_characters);
	
	__currentPhaseEnum = TURN_PHASE_ENUM.PREPARE_TURN;
}

__prepare_turn = function() {
	if(are_all_prepared(__prepare_turn_characters)) {
		__charactersToPerformAction = __prepare_turn_characters; // TODO set all characters
		__currentPhaseEnum = TURN_PHASE_ENUM.CHARACTER_ACTION_EXECUTION;
	}
	
	
	if(helper_object_is_undefined_or_empty(global.COMBAT_GLOBALS.MANAGERS.ACTION_SELECTOR)) {
		if(helper_function_is_undefined_or_noone(properties_turn_init_action_selector)) {
			properties_active_turn_character = undefined;
			properties_turn_init_action_selector = Action_Predefined_Select_Character_To_Prepare_Turn();
			properties_turn_init_action_selector.start(self);
			global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = properties_turn_init_action_selector.execute;
		}
	} else {
		properties_turn_init_action_selector = undefined;
	}
}

__currentCharIndex = 0;
__currentCharActionExecute = noone;
__charactersToPerformAction = [];
__execute_action_turn = function() {
	if(helper_object_is_undefined_or_empty(__currentCharActionExecute)) {
		__currentCharActionExecute = __charactersToPerformAction[__currentCharIndex];
		
		if(helper_object_is_undefined_or_empty(__currentCharActionExecute)) {
			__currentCharIndex = __currentCharIndex + 1;
		} else {
			__currentCharActionExecute.action_start();
		}
	}
	//__prepare_turn_characters
	////if(are_all_prepared(__prepare_turn_characters)) {
	////	__currentPhaseEnum = TURN_PHASE_ENUM.CHARACTER_ACTION_EXECUTION;
	////}
	//__currentCharIndex
	//__properties_action_is_action_done
	//for (var i = 0; i < array_length(__prepare_turn_characters); ++i) {
	//    // code here
	//}
	
}



are_all_prepared = function(instance_array) {
    // Przechodzimy przez wszystkie obiekty w tablicy
    for (var i = 0; i < array_length(instance_array); i++) {
        var inst = instance_array[i];
        
        // Sprawdzamy czy element jest instancją, istnieje i zmienna jest ustawiona
        if (!instance_exists(inst) || !inst.__properties_action_is_prepared_for_turn) {
            return false; // Jeśli którykolwiek warunek nie jest spełniony, zwracamy false
        }
    }
    
    return true; // Jeśli wszystkie obiekty spełniają warunek, zwracamy true
}


//init_turn() = function() {
//}
//is_player_turn = true;

//turn_selector = noone;

//global.chara

//switch_to_player_turn = function() {
//	playerCharacters = trunCombatCharacters.get_characters(CombatCharacterIndex.PLAYER);
	
//	for (var i = 0; i < array_length(playerCharacters); i++) {
//		playerCharacters[i].my_reset_turn();
//	}
//}
