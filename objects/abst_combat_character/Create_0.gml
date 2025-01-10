event_inherited();
my_hex_obj_type = TileObjectTypeEnum.CHARACTER;// Typ domyślny dla kafelków
my_character_side = CombatCharacterSideEnum.NEUTRAL;
my_obj_name = global.myGlobalObjName_Character;

my_draw_border_color = c_blue;
my_draw_border_radius = global.__map_tile_radius - 10;
my_draw_border_thickness = 2;

my_mouse_enter_function = global.MY_EMPTY_FUNCTION; //

// logic params
my_turn_finished = true;
my_is_selectable_to_move = false;

my_reset_turn = function() {
	my_turn_finished = false;
}


my_base_depth = global.LAYERS.characters.depth;

my_abst_after_create();