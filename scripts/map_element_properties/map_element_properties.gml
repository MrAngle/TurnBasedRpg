// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function properties_load_map_element(_objReference) 
{
	__TILE_LOCATION = new TileLocationStruct(_objReference);

	getTileLocationStruct = function() {
		return __TILE_LOCATION;
	}

	_objReference.getRow = function() {
		return self.__TILE_LOCATION.getRow();
	}

	_objReference.getCol = function() {
		return self.__TILE_LOCATION.getCol();
	}

	properties_is_map_element = true;
	
	properties_map_element_obj_type = MapElementObjectTypeEnum.NONE; // Typ domyślny dla kafelków
	// properties_map_element_row_index = 0;
	// properties_map_element_col_index = 0;
	
	map_element_set_x = function(_x) { __map_element_set_x(_x); }
	map_element_set_y = function(_y) { __map_element_set_y(_y); }
	map_element_set_x_y = function(_x, _y) { __map_element_set_x_y(_x, _y); }
	
	__map_element_set_x = function(_x) {
		self.x = _x;
	}

	__map_element_set_y = function(_y) {
		self.y = _y;
	}

	__map_element_set_x_y = function(_x, _y) {
		map_element_set_x(_x);
		map_element_set_y(_y);
	}
}