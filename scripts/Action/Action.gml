// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377



enum EVENT_ACTION_TYPE {
	ATTACK,
	STEP,
	STAND
}

function Action_TEMPLETE() 
{
	var SKILL_TYPE_VAR = EVENT_ACTION_TYPE.ATTACK;
	var ACTION_PROPERTIES = 
	{
		SKILL_TYPE: SKILL_TYPE_VAR,
		INVOKER_CHAR: noone, // character
		DESTINATION_TILE: noone, // TileClass
		ACTION_COST: function(SKILL_TYPE_VAR) {}
	}
}



function resolve_action_from_intent(intent_id, character) {
	var row = character.properties_map_element_row_index;
	var col = character.properties_map_element_col_index;

	var target_row = row;
	var target_col = col;

	switch (intent_id) {
	    case ActionIntentId.MOVE_LEFT:
	        target_col = col - 1;
	        break;

	    case ActionIntentId.MOVE_RIGHT:
	        target_col = col + 1;
	        break;

	    case ActionIntentId.MOVE_UP_LEFT:
	        target_row = row - 1;
	        target_col = row % 2 == 0 ? col - 1 : col;
	        break;

	    case ActionIntentId.MOVE_UP_RIGHT:
	        target_row = row - 1;
	        target_col = row % 2 == 0 ? col : col + 1;
	        break;

	    case ActionIntentId.MOVE_DOWN_LEFT:
	        target_row = row + 1;
	        target_col = row % 2 == 0 ? col - 1 : col;
	        break;

	    case ActionIntentId.MOVE_DOWN_RIGHT:
	        target_row = row + 1;
	        target_col = row % 2 == 0 ? col : col + 1;
	        break;

	    case ActionIntentId.AUTO_ACTION:
	        var tile = get_target_tile_to_nearest_enemy(character, row, col);
	        target_row = tile[0];
	        target_col = tile[1];
	        break;
	}

	// Znajdź docelowy tile
	var tile_target = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tile(target_row, target_col);
	var target_character = tile_target.__character;

	// Określ typ akcji
	var skill_type = helper_object_not_exists(target_character)
		? EVENT_ACTION_TYPE.STEP
		: EVENT_ACTION_TYPE.ATTACK;

	// Zbuduj strukturę akcji
	var action_struct = {
		SKILL_TYPE: skill_type,
		INVOKER_CHAR: character,
		DESTINATION_TILE: tile_target,
		ACTION_COST: function() {
			// Tu możesz rozbudować zależnie od typu akcji
			switch (skill_type) {
			    case EVENT_ACTION_TYPE.STEP:
			        return character.stats.STEP.COST.BASE;
			    case EVENT_ACTION_TYPE.ATTACK:
			        return 3; // lub inna logika
			}
			return 0;
		}
	};

	return action_struct;
}