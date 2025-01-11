if(turn_selector != noone && global.mySelectedCharacter != noone && global.mySelectedTile != noone) {
	global.myCombatMapManager.move_to(
		global.mySelectedTile._properties_map_element_row_index, 
		global.mySelectedTile._properties_map_element_col_index, 
		global.mySelectedCharacter);
		
	instance_destroy(turn_selector);
	turn_selector = noone;
	global.mySelectedTile = noone;
	
	is_player_turn = false;
	// finish turn
}

if(is_player_turn == true) {
	
	if(global.mySelectedCharacter != noone && turn_selector == noone) {
		turn_selector = instance_create_layer(0, 0, global.LAYERS.selectors.id, DestinationPointSelector);
		global.mySelectedTile = noone;
	}
	
	if(global.mySelectedCharacter == noone) {
		instance_destroy(turn_selector);
		turn_selector = noone;
	}
	
}

