// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum MapElementObjectTypeEnum {
	TERRAIN,
	CHARACTER,
	SELECTOR,
	OBSTACLE,
	NONE
}


/**
 * Tworzy nowy kafelek mapy bitewnej (MyMapTile) z określonymi właściwościami i metodami.
 *
 * @function MyMapTile
 * @param {Real} properties_map_element_row_index - Indeks wiersza kafelka na mapie.
 * @param {Real} properties_map_element_col_index - Indeks kolumny kafelka na mapie.
 * @param {Real} _x_position - Pozycja X środka kafelka.
 * @param {Real} _y_position - Pozycja Y środka kafelka.
 * @param {Asset.GMObject} _obj_terrain - Obiekt terenu przypisany do kafelka.
 * @param {Asset.GMObject} _obj_character - Obiekt postaci przypisany do kafelka.
 * @returns {Object} Obiekt reprezentujący kafelek mapy bitewnej.
 */
function MyMapTile(properties_map_element_row_index, properties_map_element_col_index, _x_position, _y_position, _obj_terrain, _obj_character) {
    var _new_MyMapTile = {
    /// @property {Real} row_index - Indeks wiersza kafelka.
    /// @property {Real} col_index - Indeks kolumny kafelka.
    /// @property {Real} x_position - Pozycja X środka kafelka.
    /// @property {Real} y_position - Pozycja Y środka kafelka.
    /// @property {Asset.GMObject} terrain - Obiekt terenu przypisany do kafelka.
    /// @property {Asset.GMObject} character - Obiekt postaci przypisany do kafelka.
        
		_properties_map_element_row_index: properties_map_element_row_index,
		_properties_map_element_col_index: properties_map_element_col_index,
		__x_position: _x_position, // jako middle centre
		__y_position: _y_position, // jako middle centre
        __terrain: _obj_terrain, //obj
        __character: _obj_character, //obj
        __obstacle: _obj_character, //obj
        __shape_selector: noone, // HexMapElementGridCoverSeletor
        
        // Metoda: Sprawdzenie, czy kafelek jest zajęty przez postać
        //is_occupied: function() {
        //    return (self.__character != noone);
        //},
		
		__init_MyMapTile: function() {
			__create_hex_selector(self);
			global.COMBAT_GLOBALS.METRICS.TILE_COUNT = global.COMBAT_GLOBALS.METRICS.TILE_COUNT + 1;
        },
		
        /// @function getRow
        /// @description Zwraca indeks wiersza kafelka.
        /// @returns {Real}
		getRow: function() {
			return self._properties_map_element_row_index;
		},
		
		getCol: function() {
			return self._properties_map_element_col_index;
		},
		
		
		has_character: function() {
			return helper_object_exists(self.__character);
		},
		
		has_turn_entity: function() {
			return helper_object_exists(self.__character);
		},
		
		get_turn_entity: function() {
			return self.__character;
		},
		
		is_walkable: function() {
			return helper_object_not_exists(self.__obstacle);
		},
		
		show: function() {
			if(self.__terrain != noone) 
				self.__terrain.visible = true;
			if(self.__obstacle != noone) 
				self.__obstacle.visible = true;
			if(self.__character != noone)
				self.__character.visible = true;
		},
		
		set_tile: function(_obj_tile, MapElementObjectTypeEnum) { //MapElementObjectTypeEnum
			__my_set_tile(self, _obj_tile, MapElementObjectTypeEnum);
		},
		
		set_tile_auto_type: function(_obj_tile) { 
			__my_set_tile(self, _obj_tile, _obj_tile.properties_map_element_obj_type);
		},

		__create_hex_selector: function(_MyMapTile) {
			_MyMapTile.__shape_selector = 
				instance_create_layer(__x_position, __y_position, global.LAYERS.selectors.id, HexMapElementGridCoverSelector);
			
			__my_set_tile_coordinates(_MyMapTile, _MyMapTile.__shape_selector);
			
			global.COMBAT_GLOBALS.METRICS.SELECTORS_COUNT = global.COMBAT_GLOBALS.METRICS.SELECTORS_COUNT + 1;
		}
    };
	
	_new_MyMapTile.__init_MyMapTile();
	return _new_MyMapTile;
}

function __my_set_tile(_obj, _obj_tile, MapElementObjectTypeEnum) {
	switch MapElementObjectTypeEnum {
		case MapElementObjectTypeEnum.TERRAIN:
			_obj.__terrain = _obj_tile;
	        break;
	    case MapElementObjectTypeEnum.OBSTACLE:
			_obj.__obstacle = _obj_tile;
	        break;
	    case MapElementObjectTypeEnum.CHARACTER:
	        _obj.__character = _obj_tile;
	        break;
	}
	
	if(_obj_tile != noone && _obj_tile != undefined) {
		__my_set_tile_coordinates(_obj, _obj_tile);
	}
}

function __my_set_tile_coordinates(_obj, _obj_tile) {
	_obj_tile.map_element_set_x_y(_obj.__x_position, _obj.__y_position);

	_obj_tile.properties_map_element_row_index = _obj._properties_map_element_row_index;
	_obj_tile.properties_map_element_col_index =  _obj._properties_map_element_col_index;
}
