if(
	(helper_function_is_undefined_or_noone(properties_turn_init_action_selector))
	//|| helper_object_is_undefined_or_empty(properties_active_turn_character) 
	//|| !instance_exists(properties_active_turn_character) 
	//|| properties_active_turn_character.__properties_action_can_perform == false
	) {
	properties_active_turn_character = undefined;
	properties_turn_init_action_selector = Action_Predefined_Select_Character_For_Turn();
	properties_turn_init_action_selector.start(self);
	global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = properties_turn_init_action_selector.execute;
}

if(!helper_object_is_undefined_or_empty(properties_active_turn_character) 
	&& instance_exists(properties_active_turn_character)) {
	
	if(properties_active_turn_character.__properties_action_can_perform == false) {
		properties_turn_init_action_selector = undefined;
	}

	//properties_turn_init_action_selector = Action_Predefined_Select_Character_For_Turn();
	//properties_turn_init_action_selector.start(self);
}

