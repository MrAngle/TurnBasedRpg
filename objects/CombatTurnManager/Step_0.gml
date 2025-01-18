if(
	(helper_function_is_undefined_or_noone(properties_turn_init_action_selector))
	//|| helper_object_is_undefined_or_empty(properties_active_turn_character) 
	//|| !instance_exists(properties_active_turn_character) 
	//|| properties_active_turn_character.__properties_action_can_perform == false
	) {
		
	
	properties_turn_init_action_selector = Action_Predefined_Select_Character_For_Turn();
	properties_turn_init_action_selector.start(self);
			//global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = closedAction(action);
		
	
	//var action = Action_Predefined_Move_In_Radius(3);
	//action.start(self);

	//var closedAction = function(arg_actionClass) {
	//	var closedFunction = {
	//		__actionClass: arg_actionClass,
	//		toReturn: function(_self) {
	//			if(!helper_struct_is_undefined_or_empty(__actionClass) ) {
	//				__actionClass.execute(_self);
	//			}
	//		}
	//	}
	//	return closedFunction.toReturn;
	//}

	//global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = closedAction(action);
	
}


//properties_active_turn_character == noone; // abst_combat_character





//if(turn_selector != noone && global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER != noone && global.COMBAT_GLOBALS.MAP.SELECTED_TILE != noone) {
//	global.COMBAT_GLOBALS.MANAGERS.COMBAT_MAP.move_to(
//		global.COMBAT_GLOBALS.MAP.SELECTED_TILE._properties_map_element_row_index, 
//		global.COMBAT_GLOBALS.MAP.SELECTED_TILE._properties_map_element_col_index, 
//		global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER);
		
//	instance_destroy(turn_selector);
//	turn_selector = noone;
//	global.COMBAT_GLOBALS.MAP.SELECTED_TILE = noone;
	
//	is_player_turn = false;
//	// finish turn
//}

//if(is_player_turn == true) {
	
//	if(global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER != noone && turn_selector == noone) {
//		turn_selector = instance_create_layer(0, 0, global.LAYERS.selectors.id, DestinationPointSelector);
//		global.COMBAT_GLOBALS.MAP.SELECTED_TILE = noone;
//	}
	
//	if(global.COMBAT_GLOBALS.MAP.SELECTED_CHARACTER == noone) {
//		instance_destroy(turn_selector);
//		turn_selector = noone;
//	}
	
//}

