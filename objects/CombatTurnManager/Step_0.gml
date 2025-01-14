if(turn_selector != noone && global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER != noone && global.COMBAT_GLOBALS.MAP.SELECTED_TILE != noone) {
	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
		global.COMBAT_GLOBALS.MAP.SELECTED_TILE._properties_map_element_row_index, 
		global.COMBAT_GLOBALS.MAP.SELECTED_TILE._properties_map_element_col_index, 
		global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER);
		
	instance_destroy(turn_selector);
	turn_selector = noone;
	global.COMBAT_GLOBALS.MAP.SELECTED_TILE = noone;
	
	is_player_turn = false;
	// finish turn
}

if(is_player_turn == true) {
	
	if(global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER != noone && turn_selector == noone) {
		turn_selector = instance_create_layer(0, 0, global.LAYERS.selectors.id, DestinationPointSelector);
		global.COMBAT_GLOBALS.MAP.SELECTED_TILE = noone;
	}
	
	if(global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER == noone) {
		instance_destroy(turn_selector);
		turn_selector = noone;
	}
	
}

