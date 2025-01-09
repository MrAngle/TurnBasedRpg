// DRAW PROPERTIES
my_obj_name = global.myGlobalObjName_None

// draw border
my_draw_border_color = c_white;
my_draw_border_radius = global.__map_tile_radius;
my_draw_border_thickness = 3;

// on mouse enter
my_mouse_enter_function = global.MY_EMPTY_FUNCTION;

// LOGIC PRoperties:
my_hex_obj_type = TileObjectTypeEnum.NONE; // Typ domyślny dla kafelków
_row_index = 0;
_col_index = 0;

// LAYERS properties
my_base_depth = 0;

my_abst_after_create = function() {
	depth = my_base_depth;
}