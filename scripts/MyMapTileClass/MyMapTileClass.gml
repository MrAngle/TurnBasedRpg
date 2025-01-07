// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum TileObjectTypeEnum {
	TERRAIN,
	CHARACTER
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
        is_occupied: function() {
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
		}

    };
}

function __my_set_tile(_obj, _obj_tile, tileObjectTypeEnum) {
	switch tileObjectTypeEnum {
	    case TileObjectTypeEnum.TERRAIN:
			_obj.__terrain = _obj_tile;
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
	_obj_tile.x = _obj.__x_position;
	_obj_tile.y = _obj.__y_position;

	_obj_tile._row_index = _obj.__row_index;
	_obj_tile._col_index =  _obj.__col_index;
}
