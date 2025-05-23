enum CombatCharacterIndex {
	PLAYER = 0,
	ENEMY = 1,
	NEUTRAL = 2
}

function CombatCharactersHolderClass(_character_list) {
    return {
		__character_list: _character_list, // [players, enemies, neutrals];
        
        // Metoda: Sprawdzenie, czy kafelek jest zajęty przez postać
        //is_occupied: function() {
        //    return (self.__character != noone);
        //},
		
		get_characters: function(combat_character_index /* CombatCharacterIndex */) { 
			return (self.__character_list[combat_character_index]);
		},
		
		get_all_characters: function(combat_character_index /* CombatCharacterIndex */) { 
			return self.__character_list; // [players, enemies, neutrals];
		},
		
		set_characters: function(_character_list /* [players, enemies, neutrals] */) { 
			self.__character_list = _character_list;
		},

    };
}