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

// Properties
properties_load_after_create_executed(self);

// flag to determine if after_create_event was invoked
// Definition Functions
set_x = function(_x) { __abst_tile_set_x(_x); }
set_y = function(_y) { __abst_tile_set_y(_y); }
set_x_y = function(_x, _y) { __abst_tile_set_x_y(_x, _y); }

set_depth = function(_depth) { __abst_tile_set_depth(_depth); }

after_create_event = function() { __abst_tile_after_create(); } // should be as last action of create event of every child

// IMPL
__abst_tile_set_x = function(_x) {
	self.x = _x;
}

__abst_tile_set_y = function(_y) {
	self.y = _y;
}

__abst_tile_set_x_y = function(_x, _y) {
	self.set_x(_x);
	self.set_y(_y);
}

__abst_tile_set_depth = function(_depth) {
	self.depth = _depth;
}

__abst_tile_after_create = function() {
	set_depth(my_base_depth);
	
	after_create_executed = true;
}

