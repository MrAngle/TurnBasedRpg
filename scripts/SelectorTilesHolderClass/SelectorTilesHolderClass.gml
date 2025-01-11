// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

enum SELECTOR_STORE_STRATEGY {
	REPLACE_FIRST_WHEN_MAX,
	REPLACE_LAST_WHEN_MAX,
	IGNORE_WHEN_MAX
}

function SelectorTilesHolderClass(_maxElements, _SELECTOR_TYPE_ENUM, _SELECTOR_STORE_STRATEGY) {
    var map_SelectorTilesHolderClass = {
		
		__selector_SelectorTileClass: array_create(_maxElements), // SelectorTileClass[]
        __selector_type: _SELECTOR_TYPE_ENUM, // SELECTOR_TYPE_ENUM
		__selector_store_strategy: _SELECTOR_STORE_STRATEGY,
        
		// constructor
		__init_SelectorTilesHolderClass: function() {
			//HexFieldSelectorDecorationFactory(__hex_selectedFieldDecoration, _SELECTOR_TYPE_ENUM)
        },
		
		set_tile_MyMapTile: function(_MyMapTile) {
			if(__can_add_selector_tile() == true) {
				var _SelectorTileClass = SelectorTileClass(_MyMapTile, __selector_type);
				
				add_selector_tile_SelectorTileClass(_SelectorTileClass);
			}
		},
		
		add_selector_tile_SelectorTileClass: function(_SelectorTileClass) {
			var _addElementFunc = __get_selector_store_function_add_SelectorTileClass()
			
			_addElementFunc(_SelectorTileClass);
		},
		
		__get_selector_store_function_add_SelectorTileClass: function() {
		    switch (self.__selector_store_strategy) {
		        case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
		            return function(_SelectorTileClass) {
		                var currentCount = array_length(self.__selector_SelectorTileClass);
		                if (currentCount >= self.__maxElements) {
		                    // Zastępujemy pierwszy element
		                    self.__selector_SelectorTileClass[0] = _SelectorTileClass;
		                } else {
		                    array_push(self.__selector_SelectorTileClass, _SelectorTileClass);
		                }
		            };

		        case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
		            return function(_SelectorTileClass) {
		                var currentCount = array_length(self.__selector_SelectorTileClass);
		                if (currentCount >= self.__maxElements) {
		                    // Zastępujemy ostatni element
		                    self.__selector_SelectorTileClass[currentCount - 1] = _SelectorTileClass;
		                } else {
		                    array_push(self.__selector_SelectorTileClass, _SelectorTileClass);
		                }
		            };

		        case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
		            return function(_SelectorTileClass) {
		                var currentCount = array_length(self.__selector_SelectorTileClass);
		                if (currentCount < self.__maxElements) {
		                    array_push(self.__selector_SelectorTileClass, _SelectorTileClass);
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
		    var currentCount = array_length(self.__selector_SelectorTileClass);

		    switch (self.__selector_store_strategy) {
		        case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
		            // W strategii zastępowania zawsze można dodać element (zastąpienie)
		            return true;

		        case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
		            // W strategii zastępowania zawsze można dodać element (zastąpienie)
		            return true;

		        case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
		            // W strategii ignorowania, dodanie jest możliwe tylko, gdy liczba elementów jest mniejsza od maksymalnej
		            return currentCount < self.__maxElements;

		        default:
		            // Nieznana strategia, zwracamy false jako domyślną wartość
		            show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
		            return false;
		    }
		}

		

		//get_tile: function(_row, _col) { // MyMapTile
		//	return self.__map_holder[_row][_col];
		//},
		
		//get_tile_centrum_coodinators: function(_row, _col) { // MyMapTile
		//	return [self.__map_holder[_row][_col].__x_position, self.__map_holder[_row][_col].__y_position];
		//},

		//show_tiles: function() {
		//	__my_show_tiles(self);
		//},
		
		//find_character_in_map: function(_obj_target) {
		//	return __find_character_in_map(self.__map_holder, self.__rows, self.__cols, _obj_target);
		//}
    };
	
	map_SelectorTilesHolderClass.__init_SelectorTilesHolderClass();
	return map_SelectorTilesHolderClass;
}