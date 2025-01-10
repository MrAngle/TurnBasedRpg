// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum MapElementObjectTypeEnum {
	TERRAIN,
	CHARACTER,
	NONE
}


function MyMapTile(properties_map_element_row_index, properties_map_element_col_index, _x_position, _y_position, _obj_terrain, _obj_character) {
    return {
		_properties_map_element_row_index: properties_map_element_row_index,
		_properties_map_element_col_index: properties_map_element_col_index,
		__x_position: _x_position, // jako middle centre
		__y_position: _y_position, // jako middle centre
        __terrain: _obj_terrain, //obj
        __character: _obj_character, //obj
        
        // Metoda: Sprawdzenie, czy kafelek jest zajęty przez postać
        //is_occupied: function() {
        //    return (self.__character != noone);
        //},
		
		has_character: function() {
			return (self.__character != noone);
		},
		
		show: function() {
			if(self.__terrain != noone) 
				self.__terrain.visible = true;
			if(self.__character != noone)
				self.__character.visible = true;
		},
		
		set_tile: function(_obj_tile, MapElementObjectTypeEnum) { //MapElementObjectTypeEnum
			__my_set_tile(self, _obj_tile, MapElementObjectTypeEnum);
		},
		
		set_tile_auto_type: function(_obj_tile) { 
			__my_set_tile(self, _obj_tile, _obj_tile.properties_map_element_obj_type);
		}

    };
}

function __my_set_tile(_obj, _obj_tile, MapElementObjectTypeEnum) {
	switch MapElementObjectTypeEnum {
	    case MapElementObjectTypeEnum.TERRAIN:
			_obj.__terrain = _obj_tile;
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
