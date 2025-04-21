// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
//global.STATISTICS = {
//    MOVEMENT: "MOVEMENT",
//    PHYSICAL_ATTACK: "PHYSICAL_ATTACK",
//    MAGIC_ATTACK: "MAGIC_ATTACK",
//    HP: "HP",
	
//	CALCULATE_VALUE_FUNC: "CALCULATE_VALUE_FUNC"
//};

//enum ACTION_TYPE {
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

/// @function performMoveAction(source_char, destination_row, destination_col)
/// @description Wykonuje akcję ruchu postaci na wskazane pole mapy.
/// @param {Id.Instance} arg_source_char - Instancja postaci wykonującej ruch.
/// @param {Real} arg_destinarion_row - Docelowy wiersz na mapie.
/// @param {Real} arg_destination_col - Docelowa kolumna na mapie.
/// @returns {Void}
function performMoveAction(arg_source_char, arg_destinarion_row, arg_destination_col) {
	global.COMBAT_GLOBALS.ACTION.PROCESSING = true;

	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
		arg_destinarion_row,
		arg_destination_col,
		arg_source_char);
}

function performAttackAction(arg_source_char, arg_dest_char) {
	getTurnEntityStruct(arg_dest_char).receiveDamage(getTurnEntityStruct(arg_source_char).getAttackValue());
	
}