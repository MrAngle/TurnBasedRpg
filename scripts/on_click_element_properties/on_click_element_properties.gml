

function properties_load_on_click_element()
{
	properties_is_on_click_element = true;
	
	properties_on_click_is_selected = false;
	
	

	on_click_element = function() {
		__on_click_element();
	}
	
	on_click_change_selected_status = function() {
		properties_on_click_is_selected = !properties_on_click_is_selected;
	}
	
	__on_click_element = function() {
		if(properties_is_map_element != noone && properties_is_map_element == true) {
			select_map_tile(getRow(), getCol());
		}
		
		on_click_change_selected_status();
	}
}

function select_map_tile(_row_index, _col_index) {

	var selectedTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(_row_index, _col_index);
	if(selectedTile != global.COMBAT_GLOBALS.MAP.SELECTED_TILE) {
		global.COMBAT_GLOBALS.MAP.SELECTED_TILE = selectedTile;
		
		if(global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER == noone) {
			global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER = selectedTile.__character;
		}
		
	} else {
		global.COMBAT_GLOBALS.MAP.SELECTED_TILE = noone;
		global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER = noone;
	}
}

//function set_border_col(_row_index, _col_index) {
//	global.COMBAT_GLOBALS.MAP.SELECTED_TILE = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(_row_index, _col_index);
//}