function MyCombatMapManager(_combat_map_holder) {
    var combat_map_manager_instance = {
        /// @param {Struct.__MyCombatMapHolder} __combat_map_holder
        __combat_map_holder: _combat_map_holder, // MyCombatMapHolder

		// constructor
		init: function() {
        },

		move_to: function(_targetproperties_map_element_row_index, _targetproperties_map_element_col_index, _target_obj) {
			__my_move_to(self, _targetproperties_map_element_row_index, _targetproperties_map_element_col_index, _target_obj)
		},
		
		get_all_characters_on_map: function() {
			return __get_all_characters_on_map(self)
		},

    };
	
	combat_map_manager_instance.init();
	return combat_map_manager_instance;
}

/// @param {Struct.MyCombatMapManager} _obj
function __get_all_characters_on_map(_obj) {
    // Tworzenie list dla każdej grupy postaci
    var players = [];
	var enemies = [];
    var neutrals = [];
    
    // Skanowanie mapy
    for (var row = 0; row < _obj.__combat_map_holder.__rows; row++) {
        var row_tiles = _obj.__combat_map_holder.__map_holder[row];
        
        for (var col = 0; col < _obj.__combat_map_holder.__cols; col++) {
            var tile = row_tiles[col];
            
            // Jeśli kafelek jest zajęty
            if (tile.has_character()) {
                var character = tile.__character;
                
                // Przypisanie postaci do odpowiedniej listy
                switch (character.getFaction()) {
                    case CombatCharacterSideEnum.PLAYER:
                        array_push(players, character);
                        break;
                    case CombatCharacterSideEnum.NEUTRAL:
                        array_push(neutrals, character);
                        break;
                    case CombatCharacterSideEnum.ENEMY:
                        array_push(enemies, character);
                        break;
                }
            }
        }
    }
    
    // Zwrócenie arraya
    return [players, enemies, neutrals];
};

function __my_move_to(_obj,_targetproperties_map_element_row_index, _targetproperties_map_element_col_index, _target_obj) {
	var currentPositionMyMapTile = __combat_map_holder.get_tile(_target_obj.properties_map_element_row_index, _target_obj.properties_map_element_col_index);
	var destinationMyMapTile = __combat_map_holder.get_tile(_targetproperties_map_element_row_index, _targetproperties_map_element_col_index);
	
	currentPositionMyMapTile.set_tile(noone, MapElementObjectTypeEnum.CHARACTER);
	destinationMyMapTile.set_tile_auto_type(_target_obj);
}
