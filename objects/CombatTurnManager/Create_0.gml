//[players, enemies, neutrals];
trunCombatCharacters = global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER;

combatCharactersHolderClass = CombatCharactersHolderClass(global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.get_all_characters_on_map())
global.COMBAT_GLOBALS.STORE.ACTIVE_CHARACTERS_HOLDER = combatCharactersHolderClass;

properties_turn_init_action_selector = noone;
properties_active_turn_character = noone; // abst_combat_character

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
