

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
			select_map_tile(properties_map_element_row_index, properties_map_element_col_index);
		}
		
		on_click_change_selected_status();
	}
}

function select_map_tile(_row_index, _col_index) {

	var selectedTile = global.myCombatMapHolder.get_tile(_row_index, _col_index);
	if(selectedTile != global.mySelectedTile) {
		global.mySelectedTile = selectedTile;
		
		if(global.mySelectedCharacter == noone) {
			global.mySelectedCharacter = selectedTile.__character;
		}
		
	} else {
		global.mySelectedTile = noone;
		global.mySelectedCharacter = noone;
	}
}

//function set_border_col(_row_index, _col_index) {
//	global.mySelectedTile = global.myCombatMapHolder.get_tile(_row_index, _col_index);
//}