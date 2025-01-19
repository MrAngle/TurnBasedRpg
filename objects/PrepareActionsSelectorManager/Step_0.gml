if(array_length(__actions_selected) > 0) {
	
	//var action = __actions_selected[0];
	properties_character_to_prepare_actions.actions_selected_to_perform_set(__actions_selected);
	
	instance_destroy(self);
	//__actions_selected = [];
}