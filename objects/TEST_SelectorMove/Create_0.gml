show_debug_message("START - INIT TEST_SelectorMove");

//testActionsManager = TEST_SC_SelectorAction_chain_cancel() ;

var nextScenario = GET_NEXT_TEST_SCENAIO();

if(helper_function_is_undefined_or_noone(nextScenario)) {
	global.GAME_GLOBALS.TEST.FINISHED = true;
	return;
}
testActionsManager = nextScenario();

testActionsManager.add(function() {
	if(global.TEST_FINISH_SCENARIO) {
		global.GAME_GLOBALS.TEST.SCENARIO_INDEX = global.GAME_GLOBALS.TEST.SCENARIO_INDEX + 1;
		helper_room_move_to_previous_room();
	}
}, global.TEST_DEFAULT_SCENARIO_DELAY);
//global.GAME_GLOBALS.TEST.SCENARIO_INDEX

//var suites = GET_NEXT_TEST_SCENAIO()();

//testActionsManager

//FINISHED
// AFTER MANAGER LOAD
alarm[2] = 10;
show_debug_message("FINISH - INIT TEST_SelectorMove");
