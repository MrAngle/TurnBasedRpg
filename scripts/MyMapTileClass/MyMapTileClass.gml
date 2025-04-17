
/// @typedef {object} Struct.MyMapTile
/// @property {Real} _properties_map_element_row_index
/// @property {Real} _properties_map_element_col_index
/// @property {Real} __x_position
/// @property {Real} __y_position
/// @property {Asset.GMObject} __terrain
/// @property {Asset.GMObject} __character
/// @property {Asset.GMObject} __obstacle
/// @property {Instance} __shape_selector
/// @property {function(): Real} getRow
/// @property {function(Struct.MyMapTile): void} set_tile_auto_type


// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
enum MapElementObjectTypeEnum {
	TERRAIN,
	CHARACTER,
	SELECTOR,
	OBSTACLE,
	NONE
}

/// @function MyMapTileInit
/// @param {Struct.MyMapTile} tile
function MyMapTileBuilder(properties_map_element_row_index, properties_map_element_col_index, _x_position, _y_position, _obj_terrain, _obj_character) {
	var myMapTile = new MyMapTile(properties_map_element_row_index, properties_map_element_col_index, _x_position, _y_position, _obj_terrain, _obj_character)

    myMapTile.__create_hex_selector();
    global.COMBAT_GLOBALS.METRICS.TILE_COUNT = global.COMBAT_GLOBALS.METRICS.TILE_COUNT + 1;

    return myMapTile;
}

/// @constructor
/// @returns {Struct.MyMapTile}
function MyMapTile(properties_map_element_row_index, properties_map_element_col_index, _x_position, _y_position, _obj_terrain, _obj_character) constructor {
    _properties_map_element_row_index = properties_map_element_row_index;
    _properties_map_element_col_index = properties_map_element_col_index;
    __x_position = _x_position;
    __y_position = _y_position;
    __terrain = _obj_terrain;
    __character = _obj_character;
    __obstacle = _obj_character;
    __shape_selector = noone;

	getInteractiveObject = function() {
        return __character;
    };

    getRow = function() {
        return _properties_map_element_row_index;
    };

    getCol = function() {
        return _properties_map_element_col_index;
    };

    has_character = function() {
        return helper_object_exists(__character);
    };

    has_turn_entity = function() {
        return helper_object_exists(__character);
    };

    get_turn_entity = function() {
        return __character;
    };

    is_walkable = function() {
        return helper_object_not_exists(__obstacle);
    };

    show = function() {
        if (__terrain != noone)
            __terrain.visible = true;
        if (__obstacle != noone)
            __obstacle.visible = true;
        if (__character != noone)
            __character.visible = true;
    };

    set_tile = function(_obj_tile, MapElementObjectTypeEnum) {
        __my_set_tile(self, _obj_tile, MapElementObjectTypeEnum);
    };

    set_tile_auto_type = function(_obj_tile) {
        __my_set_tile(self, _obj_tile, _obj_tile.properties_map_element_obj_type);
    };

    __create_hex_selector = function() {
        __shape_selector = instance_create_layer(__x_position, __y_position, global.LAYERS.selectors.id, HexMapElementGridCoverSelector);
        __my_set_tile_coordinates(self, __shape_selector);
        global.COMBAT_GLOBALS.METRICS.SELECTORS_COUNT += 1;
    };

    // Inicjalizacja struktury
    __create_hex_selector();
    global.COMBAT_GLOBALS.METRICS.TILE_COUNT += 1;
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
