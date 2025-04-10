var row_index = character.properties_map_element_row_index;
var col_index = character.properties_map_element_col_index;

//global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
//	row_index + 1, 
//	row_index % 2 == 0 ? col_index - 1 : col_index,
//	character);
	
performEvent(character, row_index + 1, row_index % 2 == 0 ? col_index - 1 : col_index)