my_mouse_enter_function = function() {
	global.myActiveHoveredTile = global.myCombatMapHolder.get_tile(properties_map_element_row_index, properties_map_element_col_index);
}

event_inherited();