// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

// LOGGERS NOT THROW EXCEPTIONS
function LOG_DEBUG_MESSAGE(arg_mgs) 
{
	global.GAME_GLOBALS.DEVELOPER_SETTINGS.LOG_FUNCTION(string(arg_mgs), global.LOG_LEVEL.DEBUG)
}


function LOG_INFO_MESSAGE(arg_mgs) 
{
	global.GAME_GLOBALS.DEVELOPER_SETTINGS.LOG_FUNCTION(string(arg_mgs), global.LOG_LEVEL.INFO)
}

function LOG_ERROR_MESSAGE(arg_mgs) 
{
	global.GAME_GLOBALS.DEVELOPER_SETTINGS.LOG_FUNCTION(string(arg_mgs), global.LOG_LEVEL.ERROR)
}

function LOG_CRITICAL_MESSAGE(arg_mgs) 
{
	global.GAME_GLOBALS.DEVELOPER_SETTINGS.LOG_FUNCTION(string(arg_mgs), global.LOG_LEVEL.CRITICAL)
}