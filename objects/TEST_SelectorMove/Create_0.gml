if(global.TEST_ACTIVE == false) {
	return
}


show_debug_message("START - INIT TEST_SelectorMove");

//testActionsManager = TEST_SC_SelectorAction_chain();
testActionsManager = TEST_SC_SelectorAction_chain_cancel() ;

// AFTER MANAGER LOAD
alarm[0] = 1;
//alarm[0] = global.COMBAT_GLOBALS.ALARM.PERIOD_MINIMUM;
alarm[1] = 1 + 10;
//alarm[1] = global.COMBAT_GLOBALS.ALARM.PERIOD_MINIMUM + 10;
show_debug_message("FINISH - INIT TEST_SelectorMove");
