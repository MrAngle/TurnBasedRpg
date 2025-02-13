if(array_length(__actions_selected) > 0) {
	
	//var action = __actions_selected[0];
	global.COMBAT_GLOBALS.ACTION_PREPARATION.CURRENT_CHARACTER_TO_PREPARE
		.prepare_trun_actions_selected_to_perform_set(__actions_selected);
	
	instance_destroy(self);
	//__actions_selected = [];
}