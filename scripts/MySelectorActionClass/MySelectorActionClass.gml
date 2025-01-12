// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377


//MySelectorActionClass


function MySelectorActionClassOptionalConstrParams() {
    return {
        _selector_function: noone,
        _numberOfTilesToSelect: 1,
        _SELECTOR_TYPE_ENUM: SELECTOR_TYPE_ENUM.SELECTED,
        _SELECTOR_STORE_STRATEGY: SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX,
        _previous_selected_SelectorTilesHolderClass: noone
    };
}



function MySelectorActionClass(_possible_tiles_to_choose_function, _MySelectorActionClassOptionalConstrParams = MySelectorActionClassOptionalConstrParams())
{
    var _mySelectorActionClass = {
		__possible_tiles_to_choose_function: _possible_tiles_to_choose_function, // (_self, SelectorTilesHolderClass, SelectorTilesHolderClass)
		__selector_function: 
			_MySelectorActionClassOptionalConstrParams._selector_function, // (_self, SelectorTilesHolderClass)
		__numberOfTilesToSelect: 
			_MySelectorActionClassOptionalConstrParams._numberOfTilesToSelect,
		__SELECTOR_TYPE: 
			_MySelectorActionClassOptionalConstrParams._SELECTOR_TYPE_ENUM,
		__SELECTOR_STORE_STRATEGY: 
			_MySelectorActionClassOptionalConstrParams._SELECTOR_STORE_STRATEGY,
		//__next_MySelectorActionClass: _next_MySelectorActionClass, // MySelectorActionClass
		
		//_previous_selected_SelectorTilesHolderClass
		__result_SelectorTilesHolderClass: noone, // SelectorTilesHolderClass
		__previous_result_SelectorTilesHolderClass: _MySelectorActionClassOptionalConstrParams._previous_selected_SelectorTilesHolderClass, // SelectorTilesHolderClass
		__selector_possible_tiles_to_choose_SelectorTilesHolderClass: noone, // SelectorTilesHolderClass
		//__previous_MySelectorActionClass: _previous_MySelectorActionClass, // MySelectorActionClass
		
		__action_finished: false,
		
		// constructor
		__init_MySelectorActionClass: function() {
			__result_SelectorTilesHolderClass = 
				SelectorTilesHolderClass(
					__numberOfTilesToSelect, 
					__SELECTOR_TYPE, 
					__SELECTOR_STORE_STRATEGY);
	    },

		load_possible_moves: function(_self) {
			if(helper_struct_is_undefined_or_empty(__result_SelectorTilesHolderClass)) { // after cancel
				__init_MySelectorActionClass();
			}

			self.__destroy__selector_possible_tiles_to_choose_SelectorTilesHolderClass();
			
			if(__possible_tiles_to_choose_function != noone) {
				var _selectableTile_arrayMyMapTiles = 
					__possible_tiles_to_choose_function(
						_self, 
						__result_SelectorTilesHolderClass, 
						__previous_result_SelectorTilesHolderClass
					);
				
				if(!helper_array_is_undefined_or_empty(_selectableTile_arrayMyMapTiles)) {
					self.__selector_possible_tiles_to_choose_SelectorTilesHolderClass = SelectorTilesHolderClass(
						helper_array_length_safe(_selectableTile_arrayMyMapTiles), 
						SELECTOR_TYPE_ENUM.POSSIBLE_MOVES, 
						SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX,
						_selectableTile_arrayMyMapTiles);
				}
			}
		},
		
		execute: function(_self) {
			if(__action_finished) {
				return;
			}
			
			if(helper_struct_is_undefined_or_empty(__result_SelectorTilesHolderClass)) { // after cancel
				__init_MySelectorActionClass();
			}
			
			var moveIsAccepted = __process_move(_self);
			//__selector_function(_self, __result_SelectorTilesHolderClass);
			
			if(__result_SelectorTilesHolderClass.get_size() >= __numberOfTilesToSelect) {
				__action_finished = true;
				__destroy__selector_possible_tiles_to_choose_SelectorTilesHolderClass(self);
			} else {
				if(moveIsAccepted) {
					self.load_possible_moves();
				}
			}
		},
		
		__process_move: function(_self) {
			var _MyMapTile = global.myCombatMapHolder.get_tile(_self.properties_map_element_row_index, _self.properties_map_element_col_index);

			if(
				!helper_struct_is_undefined_or_empty(__selector_possible_tiles_to_choose_SelectorTilesHolderClass) &&
				helper_array_is_contain_element(__selector_possible_tiles_to_choose_SelectorTilesHolderClass.get_all_myMapTiles_as_array(), _MyMapTile))
			{
				__result_SelectorTilesHolderClass.add_tile_MyMapTile(_MyMapTile);
				return true;
			}
			return false;
		},
				
		__cancel_move: function(_self) {
			__destroy__result_SelectorTilesHolderClass();
			__destroy__selector_possible_tiles_to_choose_SelectorTilesHolderClass();
			
			self.__action_finished = false;
		},
		
		__reset_move: function(_self) {
			self.__action_finished = false;

			__destroy__result_SelectorTilesHolderClass();
			load_possible_moves(_self);
		},
				
		// Metoda destrukcji
        __destroy: function() {
            // Sprawdzenie i zniszczenie SelectorTilesHolderClass
			__destroy__result_SelectorTilesHolderClass();
			__destroy__selector_possible_tiles_to_choose_SelectorTilesHolderClass();
            self.__action_finished = true;
        },
		
			
		__destroy__selector_possible_tiles_to_choose_SelectorTilesHolderClass: function() {
			if (self.__selector_possible_tiles_to_choose_SelectorTilesHolderClass != noone) {
                self.__selector_possible_tiles_to_choose_SelectorTilesHolderClass.destroy();
                self.__selector_possible_tiles_to_choose_SelectorTilesHolderClass = noone;
            }
		},
		
		__destroy__result_SelectorTilesHolderClass: function() {
			if (self.__result_SelectorTilesHolderClass != noone) {
                self.__result_SelectorTilesHolderClass.destroy();
                self.__result_SelectorTilesHolderClass = noone;
            }
		},
	};
	
	_mySelectorActionClass.__init_MySelectorActionClass();
	return _mySelectorActionClass;
}


function MySelectorActionManagerClass(_dsListOfMySelectorActionClass)
{
    var _mySelectorActionManagerClass = {
		__selector_MySelectorActions: _dsListOfMySelectorActionClass,
		__selector_action_index: 0,
		__selector_actions_finished: false,
		__selector_actions_cancelled: false,
		//__action_next_function: _action_next_function,
		
		// constructor
		__init_MySelectorActionManagerClass: function() {
	    },
		
		start: function(_self) {
			var _actionToInvoke = __selector_MySelectorActions[| __selector_action_index];
			
			_actionToInvoke.load_possible_moves(_self);
		},
		
		execute: function(_self) {
			if(__selector_action_index >= ds_list_size(__selector_MySelectorActions)) {
				__selector_actions_finished = true;
				return;
			}
			var _actionToInvoke = __selector_MySelectorActions[| __selector_action_index];
			
			_actionToInvoke.execute(_self);
			
			if(_actionToInvoke.__action_finished) {
				if(__selector_action_index >= ds_list_size(__selector_MySelectorActions) - 1) {
					__selector_actions_finished = true;
					return;
				}
				__selector_action_index = __selector_action_index + 1;
				
				get_current_action().__previous_result_SelectorTilesHolderClass =
					__selector_MySelectorActions[| __selector_action_index - 1].__result_SelectorTilesHolderClass
				get_current_action().load_possible_moves(_self);
			}
		},
		
		cancel_current_move: function(_self) {
			get_current_action().__cancel_move(_self);
			
			if(__selector_action_index == 0) {
				__selector_actions_cancelled = true;
			} else {
				__selector_action_index = __selector_action_index - 1;
			}
			
			// rest selected move
			get_current_action().__reset_move(_self);
		},
		
		get_current_action: function() {
			return __selector_MySelectorActions[| __selector_action_index];
		},
		
		// Metoda destrukcji
        destroy: function() {
            var actions = self.__selector_MySelectorActions;

            if (actions != noone) {
                // Iteracja przez wszystkie akcje w liście
                for (var i = 0; i < ds_list_size(actions); i++) {
                    var action = actions[| i];
                    if (action != noone) {
                        // Wywołanie metody destroy dla każdej akcji
                        action.__destroy();
                    }
                }
                // Zniszczenie listy
                ds_list_destroy(actions);
                self.__selector_MySelectorActions = noone;
            }

        }
	};
	
	_mySelectorActionManagerClass.__init_MySelectorActionManagerClass();
	return _mySelectorActionManagerClass;
}
