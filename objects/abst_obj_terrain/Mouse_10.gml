my_mouse_enter_function = function() {
	global.myActiveHoveredTile = global.myCombatMapHolder.get_tile(_row_index, _col_index);
}

event_inherited();