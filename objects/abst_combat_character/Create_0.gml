event_inherited();
properties_map_element_obj_type = MapElementObjectTypeEnum.CHARACTER;// Typ domyślny dla kafelków
my_character_side = CombatCharacterSideEnum.NEUTRAL;
my_obj_name = global.myGlobalObjName_Character;

//properties_border_decoration_default_color = c_blue;
//properties_border_decoration_radius = global.__map_tile_radius - 80;
//properties_border_decoration_thickness = 10;

//my_mouse_enter_function = global.MY_EMPTY_FUNCTION; //

// logic params
my_turn_finished = true;
my_is_selectable_to_move = false;

my_reset_turn = function() {
	my_turn_finished = false;
}


properties_layer_base_depth = global.LAYERS.characters.depth;

after_create_event();