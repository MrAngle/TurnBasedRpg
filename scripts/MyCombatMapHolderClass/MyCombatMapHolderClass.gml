// róznica kafelkow góra dół 21 pixeli góra i dół 

// Tworzenie pustej tablicy
//global.__map_holder = array_create(100);
//global.__map_rows = 100; // Liczba wierszy
//global.__map_cols = 100; // Liczba kolumn

//global.myCombatMapHolder = noone; // MyCombatMapHolder

//global.__map_tile_radius = 128 - 1; // Promień heksagonu (wysokość / 2)
//global.__map_tile_width = 214 - 1; // Szerokość heksagonu
////var w = sqrt(3) * r; // Szerokość heksagonu
//global.__map_tile_height = 2 * global.__map_tile_radius; // Wysokość heksagonu

function MyCombatMapHolder(_init_rows, _init_cols) {
    var map_instance = {
        __rows: _init_rows, // number
        __cols: _init_cols, // number
		__map_holder: array_create(_init_rows), // Array of arrays of MyMapTile class
        
		// constructor
		init: function() {
			__my_map_holder_init(self);
        },

		get_tile: function(_row, _col) { // MyMapTile
			return self.__map_holder[_row][_col];
		},

		show_tiles: function() {
			__my_show_tiles(self);
		},
		
		find_character_in_map: function(_obj_target) {
			return __find_character_in_map(self.__map_holder, self.__rows, self.__cols, _obj_target);
		}
    };
	
	map_instance.init();
	return map_instance;
}


function __my_map_holder_init(_obj) {
	for (var row = 0; row < _obj.__rows; row++) {
        _obj.__map_holder[row] = array_create(self.__cols);
    }
	
	
	for (var row = 0; row < _obj.__rows; row++) {
	    for (var col = 0; col < _obj.__cols; col++) {
	        // Oblicz pozycję X i Y dla każdego heksagonu
	        var pos_x = col * global.__map_tile_width + ((row % 2) * (global.__map_tile_width / 2)); // Przesunięcie co drugi wiersz
	        var pos_y = row * (1.5 * global.__map_tile_radius);
			
			var _x_position = pos_x + global.__map_tile_width;
			var _y_position =  pos_y + global.__map_tile_height;
			
			//var pos_x = col * global.__map_tile_width + ((row % 2) * (global.__map_tile_width / 2)); // Przesunięcie co drugi wiersz
	        //var pos_y = row * (1.5 * global.__map_tile_radius);
			
			//var _x_position = pos_x + global.__map_tile_width;
			//var _y_position =  pos_y + global.__map_tile_height;
			
			var mapTile = MyMapTile(row, col, _x_position, _y_position, noone, noone);
			
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

