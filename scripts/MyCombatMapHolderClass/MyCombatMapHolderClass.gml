



function MyCombatMapHolder(_init_rows, _init_cols) {
    var map_instance = {
        __rows: _init_rows, // number
        __cols: _init_cols, // number
		__map_holder: array_create(_init_rows), // Array of arrays of MyMapTile class
        
		// constructor
		__init_MyCombatMapHolder: function() {
			__my_map_holder_init(self);
        },

		get_tile: function(_row, _col) { // MyMapTile
			return self.__map_holder[_row][_col];
		},
		
		get_tile_centrum_coodinators: function(_row, _col) { // MyMapTile
			return [self.__map_holder[_row][_col].__x_position, self.__map_holder[_row][_col].__y_position];
		},

		show_tiles: function() {
			__my_show_tiles(self);
		},
		
		find_character_in_map: function(_obj_target) {
			return __find_character_in_map(self.__map_holder, self.__rows, self.__cols, _obj_target);
		},
		
		get_tile_by_character: function(_character) { // _filter_function(element) - return true 
            return  __get_tile_by_character(self, _character);
        },
		
        get_tiles: function(_filtersToCheck = [] /* MyMapTileFilters */) { // _filter_function(element) - return true 
            return  __get_tiles(self, _filtersToCheck);
        }
    };
	
	map_instance.__init_MyCombatMapHolder();
	return map_instance;
}

function __get_tiles(_obj, _filtersToCheck = []) {
    var result_tiles = []; // Tworzymy pustą tablicę

    for (var row = 0; row < _obj.__rows; row++) {
        for (var col = 0; col < _obj.__cols; col++) {
            var tile = _obj.__map_holder[row][col];
			
			if(_filtersToCheck == undefined || __passes_all_filters(_filtersToCheck, tile)) {
				array_push(result_tiles, tile);
			}
        }
    }

    return result_tiles; // Zwracamy tablicę
}

function __passes_all_filters(_filters, _myMapTile) {
	// Przeprowadzamy wszystkie filtry na danym kafelku
    for (var i = 0; i < array_length(_filters); i++) {
        var filter_function = _filters[i];
        if (!filter_function.filterFunc(_myMapTile)) {
            return false;
        }
    }
	return true;
}


function __my_map_holder_init(_obj) {
	for (var row = 0; row < _obj.__rows; row++) {
        _obj.__map_holder[row] = array_create(self.__cols);
    }
	
	for (var row = 0; row < _obj.__rows; row++) {
	    for (var col = 0; col < _obj.__cols; col++) {
	        // Oblicz pozycję X i Y dla każdego heksagonu
	        var pos_x = col * global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_WIDTH + ((row % 2) * (global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_WIDTH / 2)); // Przesunięcie co drugi wiersz
	        var pos_y = row * (1.5 * global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_RADIUS);
			
			var _x_position = pos_x + global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_WIDTH;
			var _y_position =  pos_y + global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_HEIGHT;
			
			//var pos_x = col * global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_WIDTH + ((row % 2) * (global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_WIDTH / 2)); // Przesunięcie co drugi wiersz
	        //var pos_y = row * (1.5 * global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_RADIUS);
			
			//var _x_position = pos_x + global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_WIDTH;
			//var _y_position =  pos_y + global.COMBAT_GLOBALS.VISUAL_PROPERTIES.TILE_HEIGHT;
			
			var mapTile = MyMapTileBuilder(row, col, _x_position, _y_position, noone, noone);
		
			_obj.__map_holder[row][col] = mapTile;
	    }
	}
}


function __my_show_tiles(_obj) {
	for (var row = 0; row < _obj.__rows; row++) {
		for (var col = 0; col < _obj.__cols; col++) {
			var myMapTile = _obj.__map_holder[row][col];
			
			var test = typeof(myMapTile);

			if (myMapTile != noone && typeof(myMapTile) == global.TYPEOF_STRUCT) {
				myMapTile.show(); // Ustaw widoczność na true
			}
		}
	}
}

function __get_tile_by_character(_self, obj_character) {
    for (var row = 0; row < _self.__rows; row++) {
        for (var col = 0; col < _self.__cols; col++) {
            var tile = _self.__map_holder[row][col];

            // Sprawdź, czy postać na kafelku to szukana postać
            if (!is_undefined(tile.__character) && tile.__character == obj_character) {
                return tile;
            }
        }
    }

    // Jeśli nie znaleziono, zwróć `undefined` lub null
    return undefined;
}


function __find_character_in_map(map_holder, rows, cols, obj_target) {
    for (var row = 0; row < rows; row++) {
        for (var col = 0; col < cols; col++) {
            var tile = map_holder[row][col];

            // Sprawdź, czy postać na kafelku to szukana postać
            if (!is_undefined(tile.__character) && tile.__character == obj_target) {
                return [row, col]; // Zwróć współrzędne [wiersz, kolumna]
            }
        }
    }

    // Jeśli nie znaleziono, zwróć `undefined` lub null
    return undefined;
}




