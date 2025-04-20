// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

global.LOG_LEVEL = {
    INFO: "INFO",
    ERROR: "ERROR",
	CRITICAL: "CRITICAL"
};

global.PRIVATE_SHOULD_BE_USED_ONLY_IN_SETTINGS_LOG_FUNCTION = {
    ON: function(msg, log_level) { show_debug_message("[" + log_level +"]" + msg); },
    OFF:     function(msg, log_level) {}, // for production should be OFF to not impact on performance
};


//global.GAME_GLOBALS.TEST.PASSED
global.____INIT_GAME_GLOBAL = function() {
	var vTILE_RADIUS = 128;
	var vALARM_PERIOD_MINIMUM = 1;
	
    var GLOBAL_DEFAULTS = {
        TEST: {
            ACTIVE: false,
			SCENARIO_INDEX: 0,
			PASSED: true,
			FINISHED: false
        },
		ROOM: {
			PREVIOUS_ROOM: noone
		},
		DEVELOPER_SETTINGS: {
			IGNORE_EXCEPTIONS: false,
			LOG_FUNCTION: global.PRIVATE_SHOULD_BE_USED_ONLY_IN_SETTINGS_LOG_FUNCTION.ON
		}
    };
    
    global.GAME_GLOBALS = __GAME_GLOBALS_STRUCT(GLOBAL_DEFAULTS);
	
	global.ENUMS = {};
	global.ENUMS.ACTION_TYPE = new ActionTypeEnumStruct();
	// CUSTOM CONFIG
	//global.GAME_GLOBALS.TEST.ACTIVE = true;
	//
};


function __GAME_GLOBALS_STRUCT(arg_GLOBAL_DEFAULTS) {
	var globalsStruct = {
	    TEST: {},
	    ROOM: {},
	    DEVELOPER_SETTINGS: {},
	    __GLOBAL_DEFAULTS: arg_GLOBAL_DEFAULTS,

	    __INIT: function() {
	        self.__RESET_GROUP(self.TEST, self.__GLOBAL_DEFAULTS.TEST);
	        self.__RESET_GROUP(self.ROOM, self.__GLOBAL_DEFAULTS.ROOM);
	        self.__RESET_GROUP(self.DEVELOPER_SETTINGS, self.__GLOBAL_DEFAULTS.DEVELOPER_SETTINGS);
	    },
        
	    __RESET_GROUP: function(global_variable, default_values) {
	        var keys = variable_struct_get_names(default_values);
	        for (var i = 0; i < array_length(keys); i++) {
	            var key = keys[i];
	            variable_struct_set(global_variable, key, variable_struct_get(default_values, key));
	        }
	    }
	};
	globalsStruct.__INIT();
	return globalsStruct;
}

global.TYPEOF_STRUCT = "struct";
global.TYPEOF_OBJECT = "object";
global.TYPEOF_REF = "ref";

global.MY_ROOM_SPEED = room_speed;
global.MY_EMPTY_FUNCTION = function() {};
global.MY_EMPTY_FUNCTION_WITH_2_PARAMS = function(_obj, _source) {};