// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum TileObjectTypeEnum {
	TERRAIN,
	CHARACTER,
	NONE
}


function MyMapTile(_row_index, _col_index, _x_position, _y_position, _obj_terrain, _obj_character) {
    return {
		__row_index: _row_index,
		__col_index: _col_index,
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
		
		set_tile: function(_obj_tile, tileObjectTypeEnum) { //TileObjectTypeEnum
			__my_set_tile(self, _obj_tile, tileObjectTypeEnum);
		},
		
		set_tile_auto_type: function(_obj_tile) { 
			__my_set_tile(self, _obj_tile, _obj_tile.my_hex_obj_type);
		}

    };
}

function __my_set_tile(_obj, _obj_tile, tileObjectTypeEnum) {
	switch tileObjectTypeEnum {
	    case TileObjectTypeEnum.TERRAIN:
			_obj.__terrain = _obj_tile;
			//if(_obj.__terrain.my_bg_instance != noone) {
			//	_obj.__terrain.my_bg_instance.x = _obj.__x_position;
			//	_obj.__terrain.my_bg_instance.y = _obj.__y_position;
			//}
	        break;
	    case TileObjectTypeEnum.CHARACTER:
	        _obj.__character = _obj_tile;
	        break;
	}
	
	if(_obj_tile != noone && _obj_tile != undefined) {
		__my_set_tile_coordinates(_obj, _obj_tile);
	}
}

function __my_set_tile_coordinates(_obj, _obj_tile) {
	_obj_tile.set_x_y(_obj.__x_position, _obj.__y_position);
	//_obj_tile.set_y();

	_obj_tile._row_index = _obj.__row_index;
	_obj_tile._col_index =  _obj.__col_index;
}
