// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377


function helper_throw_exception(arg_message) {
	if(!global.GAME_GLOBALS.DEVELOPER_SETTINGS.IGNORE_EXCEPTIONS) {
		helper_throw_exception_not_ignore(arg_message);
	}
	LOG_CRITICAL_MESSAGE(arg_message)
}

function helper_throw_exception_not_ignore(arg_message) {
	if(helper_is_definied(arg_message)) {
		arg_message = "THROW EXCEPTION: arg_message is undefined";
	}
	show_error("THROW EXCEPTION: " + string(arg_message), true);
}
