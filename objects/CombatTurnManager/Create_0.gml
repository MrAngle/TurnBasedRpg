//[players, enemies, neutrals];
trunCombatCharacters = global.myCombatCharactersHolderClass;

//init_turn() = function() {
//}
is_player_turn = true;

turn_selector = noone;

//global.chara

switch_to_player_turn = function() {
	playerCharacters = trunCombatCharacters.get_characters(CombatCharacterIndex.PLAYER);
	
	for (var i = 0; i < array_length(playerCharacters); i++) {
		playerCharacters[i].my_reset_turn();
	}
}
