// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

enum SELECTOR_TYPE_ENUM {
	HOVER = 1, // ITS use also for layers
	SELECTED = 2,
	ACTIVE = 3,
}

function SelectorTileClass(_myMapTile, _SELECTOR_TYPE_ENUM) {
    var map_SelectedTileClass = {
        __selector_myMapTile: _myMapTile, // myMapTile
        __selector_type: _SELECTOR_TYPE_ENUM, // SELECTOR_TYPE_ENUM
        __hexFieldSelectorDecoration: noone, // HexFieldSelectorDecoration
        
		// constructor
		__init_SelectedTileClass: function() {
			__hexFieldSelectorDecoration = 
				HexFieldSelectorDecorationFactory(__hex_selectedFieldDecoration, __selector_type)
        },

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
	
	map_SelectedTileClass.__init_SelectedTileClass();
	return map_SelectedTileClass;
}