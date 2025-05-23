// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

enum SELECTOR_TYPE_ENUM {
	HOVER, // ITS use also for layers
	SELECTED,
	ACTIVE,
	POSSIBLE_MOVES
}

enum SELECTOR_STORE_STRATEGY {
	REPLACE_FIRST_WHEN_MAX,
	REPLACE_LAST_WHEN_MAX,
	IGNORE_WHEN_MAX
}




function SelectorTilesHolderClass(_maxElements, _SELECTOR_TYPE_ENUM, _SELECTOR_STORE_STRATEGY, _myMapTilesArray = noone) {
    var map_SelectorTilesHolderClass = {
		__selector_maxElements: _maxElements,
		__selector_SelectorTileClass: ds_list_create(), // list of SelectorTileClass
        __selector_type: _SELECTOR_TYPE_ENUM, // SELECTOR_TYPE_ENUM
		__selector_store_strategy: _SELECTOR_STORE_STRATEGY,
		
		// __selector_allow_use_same_tile - TO DO
        
		// constructor
		__init_SelectorTilesHolderClass: function(_argMyMapTilesArray) {
			
			// Dodajemy kafelki z tablicy, jeśli została podana
            if (_argMyMapTilesArray != noone) {
                for (var i = 0; i < array_length(_argMyMapTilesArray); i++) {
                    var tile = _argMyMapTilesArray[i];
                    if (tile != noone) {
                        self.add_tile_MyMapTile(tile);
                    }
                }
            }
        },
		
		get_size: function() {
			return ds_list_size(self.__selector_SelectorTileClass);
		},
		
		// Metoda zwracająca wszystkie _myMapTile jako tablicę
        get_all_myMapTiles_as_array: function() {
            var myMapTiles = []; // Tworzymy pustą tablicę

            // Iterujemy przez listę SelectorTileClass
            for (var i = 0; i < ds_list_size(self.__selector_SelectorTileClass); i++) {
                var selectorTile = self.__selector_SelectorTileClass[| i];
                if (selectorTile != noone && selectorTile.__selector_myMapTile != noone) {
                    array_push(myMapTiles, selectorTile.__selector_myMapTile);
                }
            }

            return myMapTiles; // Zwracamy tablicę myMapTiles
        },
		
				// Sprawdź, czy myMapTile już istnieje
        contains_tile: function(myMapTile) {
            var list = self.__selector_SelectorTileClass;

            if (list != noone) {
                for (var i = 0; i < ds_list_size(list); i++) {
                    var tile = list[| i];
                    if (tile != noone && tile.__selector_myMapTile == myMapTile) {
                        return true;
                    }
                }
            }
            return false;
        },
		
		add_tile_MyMapTile: function(_MyMapTile) {
			if(__can_add_selector_tile() == true) {
				var _SelectorTileClass = SelectorTileClass(_MyMapTile, __selector_type);
				
				add_selector_tile_SelectorTileClass(_SelectorTileClass);
			}
		},
		
		add_selector_tile_SelectorTileClass: function(_SelectorTileClass) {
			var _addElementFunc = __get_selector_store_function_add_SelectorTileClass()
			
			var _SelectorTileClassToReplace = __get_replaced_tile(_SelectorTileClass);
			_addElementFunc(_SelectorTileClass);
			
			if(_SelectorTileClassToReplace != undefined && _SelectorTileClassToReplace != noone) {
				_SelectorTileClassToReplace.destroy();
			}
		},
		
		// Metoda destrukcji
        destroy: function() {
            var list = self.__selector_SelectorTileClass;

            if (list != noone) {
                // Iteracja po liście
                for (var i = 0; i < ds_list_size(list); i++) {
                    var tile = list[| i];
                    if (tile != noone) {
                        // Wywołanie destruktora dla SelectorTileClass
                        tile.destroy();
                    }
                }
                // Zniszczenie listy
                ds_list_destroy(list);
                self.__selector_SelectorTileClass = noone;
            }
        },
		
        __get_selector_store_function_add_SelectorTileClass: function() {
            switch (self.__selector_store_strategy) {
                case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
                    return function(_SelectorTileClass) {
                        var currentCount = ds_list_size(self.__selector_SelectorTileClass);
                        if (currentCount >= self.__selector_maxElements) {
                            // Usuń pierwszy element przed zastąpieniem
                            ds_list_delete(self.__selector_SelectorTileClass, 0);
                        }
                        ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
                    };

                case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
                    return function(_SelectorTileClass) {
                        var currentCount = ds_list_size(self.__selector_SelectorTileClass);
                        if (currentCount >= self.__selector_maxElements) {
                            // Usuń ostatni element przed zastąpieniem
                            ds_list_delete(self.__selector_SelectorTileClass, currentCount - 1);
                        }
                        ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
                    };

                case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
                    return function(_SelectorTileClass) {
                        var currentCount = ds_list_size(self.__selector_SelectorTileClass);
                        if (currentCount < self.__selector_maxElements) {
                            ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
                        }
                        // W przeciwnym razie nic nie robimy
                    };

                default:
                    return function(_SelectorTileClass) {
                        show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
                    };
            }
        },
        
        __can_add_selector_tile: function() {
            var currentCount = ds_list_size(self.__selector_SelectorTileClass);

            switch (self.__selector_store_strategy) {
                case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
                    return true; // W strategii zastępowania zawsze można dodać element
                case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
                    return true; // W strategii zastępowania zawsze można dodać element
                case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
                    return currentCount < self.__selector_maxElements; // Można dodać, jeśli nie osiągnięto limitu
                default:
                    show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
                    return false;
            }
        },
        
        __get_replaced_tile: function(_SelectorTileClass) {
            var currentCount = ds_list_size(self.__selector_SelectorTileClass);
            
            switch (self.__selector_store_strategy) {
                case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
                    if (currentCount >= self.__selector_maxElements) {
                        return self.__selector_SelectorTileClass[| 0]; // Zwraca pierwszy element
                    }
                    break;

                case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
                    if (currentCount >= self.__selector_maxElements) {
                        return self.__selector_SelectorTileClass[| currentCount - 1]; // Zwraca ostatni element
                    }
                    break;

                case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
                    return undefined; // Nic nie zostanie zastąpione
                default:
                    show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
                    return undefined;
            }

            return undefined;
        },
    };
	
	map_SelectorTilesHolderClass.__init_SelectorTilesHolderClass(_myMapTilesArray);
	return map_SelectorTilesHolderClass;
}