// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377



enum EVENT_ACTION_TYPE {
	ATTACK,
	STEP,
	STAND
}

function Action_TEMPLETE() 
{
	var ACTION_PROPERTIES = 
	{
		EVENT_ACTION_TYPE_ID: EVENT_ACTION_TYPE.ATTACK,
		INVOKER_CHAR: noone, // character
		DESTINATION_TILE: noone, // TileClass
		ACTION_COST: function(SKILL_TYPE_VAR) {}
	}
}

function resolve_action_from_intent(intent_id, character) {
	var pos = get_target_position_from_intent(intent_id, character);
	var row = pos[0];
	var col = pos[1];

	var tile = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(row, col);
	var EVENT_ACTION_TYPE_ID = resolve_skill_type(character, tile);

	return build_action_struct(character, tile, EVENT_ACTION_TYPE_ID);
}

function get_target_position_from_intent(intent_id, character) {
	var row = character.properties_map_element_row_index;
	var col = character.properties_map_element_col_index;

	if (intent_id == ActionIntentId.STAND) {
		return [row, col];
	}

	var vDirection = get_direction_from_intent(intent_id);

	if (vDirection != noone) {
		return helper_calculate_row_and_col_for_direction(vDirection, row, col);
	}

	// Fallback
	return [row, col];
}


//function get_target_position_from_intent(intent_id, character) {
//	var row = character.properties_map_element_row_index;
//	var col = character.properties_map_element_col_index;

//	var target_row = row;
//	var target_col = col;

//	switch (intent_id) {
//	    case ActionIntentId.MOVE_LEFT:
//	        target_col = col - 1;
//	        break;

//	    case ActionIntentId.MOVE_RIGHT:
//	        target_col = col + 1;
//	        break;

//	    case ActionIntentId.MOVE_UP_LEFT:
//	        target_row = row - 1;
//	        target_col = row % 2 == 0 ? col - 1 : col;
//	        break;

//	    case ActionIntentId.MOVE_UP_RIGHT:
//	        target_row = row - 1;
//	        target_col = row % 2 == 0 ? col : col + 1;
//	        break;

//	    case ActionIntentId.MOVE_DOWN_LEFT:
//	        target_row = row + 1;
//	        target_col = row % 2 == 0 ? col - 1 : col;
//	        break;

//	    case ActionIntentId.MOVE_DOWN_RIGHT:
//	        target_row = row + 1;
//	        target_col = row % 2 == 0 ? col : col + 1;
//	        break;
			
//		case ActionIntentId.STAND:
//	        break;

//	}

//	return [target_row, target_col];
//}

function resolve_skill_type(character, tile) {
	var target_character = tile.__character;
	if (helper_object_not_exists(target_character)) {
	    return EVENT_ACTION_TYPE.STEP;
	}
	
	if(target_character == character) {
		return EVENT_ACTION_TYPE.STAND;
	} else {
	    return EVENT_ACTION_TYPE.ATTACK;
	}
}

function build_action_struct(character, tile, EVENT_ACTION_TYPE_ID) {
	return {
		EVENT_ACTION_TYPE_ID: EVENT_ACTION_TYPE_ID,
		INVOKER_CHAR: character,
		DESTINATION_TILE: tile,
		ACTION_COST: function() {
			switch (EVENT_ACTION_TYPE_ID) {
			    case EVENT_ACTION_TYPE.STEP:
			        return character.stats.STEP.COST.BASE;
			    case EVENT_ACTION_TYPE.ATTACK:
			        return 3;
			}
			return 0;
		}
	};
}