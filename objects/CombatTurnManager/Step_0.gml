switch (__currentPhaseEnum) {
	case TURN_PHASE_ENUM.INIT_PREPARE_TURN:
		__init_prepare_turn();
		break;
    case TURN_PHASE_ENUM.PREPARE_TURN:
        __prepare_turn();
        break;
    case TURN_PHASE_ENUM.CHARACTER_ACTION_EXECUTION:
        __execute_action_turn();
        break;
    default:
        // code here
        break;
}





//if(!helper_object_is_undefined_or_empty(properties_active_turn_character) 
//	&& instance_exists(properties_active_turn_character)) {
		

//	if(properties_active_turn_character.__properties_action_can_perform == false) {
//		properties_turn_init_action_selector = undefined;
//	}
//}


//if(!helper_object_is_undefined_or_empty(properties_character_to_prepare_actions) 
//	&& instance_exists(properties_character_to_prepare_actions)) {
		
//	if(helper_object_is_undefined_or_empty(global.COMBAT_GLOBALS.MANAGERS.ACTION_SELECTOR)) {
//		global.COMBAT_GLOBALS.MANAGERS.ACTION_SELECTOR = instance_create_layer(0, 0, global.LAYERS.managers.id, PrepareActionsSelectorManager);
//	}
		

//	//if(properties_active_turn_character.__properties_action_can_perform == false) {
//	//	properties_turn_init_action_selector = undefined;
//	//}
//}




	
	

