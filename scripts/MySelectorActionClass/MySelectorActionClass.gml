// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377


//MySelectorActionClass


function MySelectorActionClassOptionalConstrParams() {
    return {
        _possible_tiles_to_choose_function: noone,
        _numberOfTilesToSelect: 1,
        _SELECTOR_TYPE_ENUM: SELECTOR_TYPE_ENUM.SELECTED,
        _SELECTOR_STORE_STRATEGY: SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX,
        _previous_selected_SelectorTilesHolderClass: noone
    };
}



function MySelectorActionClass(_selector_function, _MySelectorActionClassOptionalConstrParams = MySelectorActionClassOptionalConstrParams())
// opt
	//_possible_tiles_to_choose_function = noone,
	//_numberOfTilesToSelect = 1,
	//_SELECTOR_TYPE_ENUM = SELECTOR_TYPE_ENUM.SELECTED,
	//_SELECTOR_STORE_STRATEGY = SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX,
	//_previous_selected_SelectorTilesHolderClass = noone)
{
    var _mySelectorActionClass = {
		__selector_function: _selector_function, // (_self, SelectorTilesHolderClass)
		__possible_tiles_to_choose_function: _MySelectorActionClassOptionalConstrParams._possible_tiles_to_choose_function, // (_self, SelectorTilesHolderClass)
		__numberOfTilesToSelect: _MySelectorActionClassOptionalConstrParams._numberOfTilesToSelect,
		__SELECTOR_TYPE: _MySelectorActionClassOptionalConstrParams._SELECTOR_TYPE_ENUM,
		__SELECTOR_STORE_STRATEGY: _MySelectorActionClassOptionalConstrParams._SELECTOR_STORE_STRATEGY,
		//__next_MySelectorActionClass: _next_MySelectorActionClass, // MySelectorActionClass
		
		//_previous_selected_SelectorTilesHolderClass
		__result_selectedTiles: noone, // SelectorTilesHolderClass
		__selector_possible_tiles_to_choose_selectedTiles: noone, // SelectorTilesHolderClass
		//__previous_MySelectorActionClass: _previous_MySelectorActionClass, // MySelectorActionClass
		
		__action_finished: false,
		
		// constructor
		__init_MySelectorActionClass: function() {
			__result_selectedTiles = 
				SelectorTilesHolderClass(
					__numberOfTilesToSelect, 
					__SELECTOR_TYPE, 
					__SELECTOR_STORE_STRATEGY);
	    },
		
		// Metoda destrukcji
        destroy: function() {
            // Sprawdzenie i zniszczenie SelectorTilesHolderClass
            if (self.__result_selectedTiles != noone) {
                self.__result_selectedTiles.destroy();
                self.__result_selectedTiles = noone;
            }
            self.__action_finished = true;
        },
		
		start: function(_self) {
			__possible_tiles_to_choose_function(_self, __result_selectedTiles);
		},
		
		execute: function(_self) {
			if(__action_finished) {
				return;
			}
			
			__selector_function(_self, __result_selectedTiles);
			
			if(__result_selectedTiles.get_size() >= __numberOfTilesToSelect) {
				__action_finished = true;	
			}
		}
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
		//__action_next_function: _action_next_function,
		
		// constructor
		__init_MySelectorActionManagerClass: function() {
	    },
		
		execute: function(_self) {
			if(__selector_action_index >= ds_list_size(__selector_MySelectorActions)) {
				__selector_actions_finished = true;
				return;
			}
			var _actionToInvoke = __selector_MySelectorActions[| __selector_action_index];
			
			_actionToInvoke.execute(_self);
			
			if(_actionToInvoke.__action_finished) {
				__selector_action_index = __selector_action_index + 1;
			}
			
			if(__selector_action_index >= ds_list_size(__selector_MySelectorActions)) {
				__selector_actions_finished = true;
			}
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
                        action.destroy();
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
