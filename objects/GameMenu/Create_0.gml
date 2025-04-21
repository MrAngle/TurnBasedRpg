// window_set_fullscreen(true);
if(!variable_struct_exists(global, "GAME_GLOBALS")) {
	global.____INIT_GAME_GLOBAL();
}

if(global.GAME_GLOBALS.TEST.FINISHED && global.GAME_GLOBALS.TEST.ACTIVE) { // TODO C
	show_debug_message("=========== TESTs FINISHED ============" )
	show_debug_message("TESTS STATUS: " + (global.GAME_GLOBALS.TEST.PASSED ? "PASSED" : "FAILED!!!"));
} else {
	helper_room_move_to_room(room_hex_1);
}


//room_goto(room_hex_1);