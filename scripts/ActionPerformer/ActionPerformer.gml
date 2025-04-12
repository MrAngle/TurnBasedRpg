// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
global.STATISTICS = {
    MOVEMENT: "MOVEMENT",
    PHYSICAL_ATTACK: "PHYSICAL_ATTACK",
    MAGIC_ATTACK: "MAGIC_ATTACK",
    HP: "HP",
	
	CALCULATE_VALUE_FUNC: "CALCULATE_VALUE_FUNC"
};

//enum EVENT_ACTION_TYPE {
//	ATTACK,
//	STEP,
//	STAND
//}

function performEvent(arg_source_char, arg_destinarion_row, arg_destination_col) 
{
	var destTile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(arg_destinarion_row, arg_destination_col);

	if(helper_object_not_exists(destTile.__character)) {
		performMoveAction(
			arg_source_char, 
			destTile._properties_map_element_row_index, 
			destTile._properties_map_element_col_index
		)
	} else {
		var destCharacter = destTile.__character;
		performAttackAction(arg_source_char, destCharacter);
	}

}

function performMoveAction(arg_source_char, arg_destinarion_row, arg_destination_col) {
	global.COMBAT_GLOBALS.ACTION.PROCESSING = true;
	var test = arg_source_char.get_ap_cost_func(global.EVENT_ACTION_TYPE.STEP);
	LOG_INFO_MESSAGE(test());
	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
		arg_destinarion_row,
		arg_destination_col,
		arg_source_char);
}

function performAttackAction(arg_source_char, arg_dest_char) {
	arg_dest_char.receiveDamage(arg_source_char.getAttackValue());
	
}