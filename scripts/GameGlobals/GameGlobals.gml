// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
global.____INIT_GAME_GLOBAL = function() {
	var vTILE_RADIUS = 128;
	var vALARM_PERIOD_MINIMUM = 1;
	
    var GLOBAL_DEFAULTS = {
        TEST: {
            ACTIVE: false
        }
    };
    
    global.GAME_GLOBALS = __GAME_GLOBALS_STRUCT(GLOBAL_DEFAULTS);
	
	// CUSTOM CONFIG
	global.GAME_GLOBALS.TEST.ACTIVE = true;
	//
};


function __GAME_GLOBALS_STRUCT(arg_GLOBAL_DEFAULTS) {
	var globalsStruct = {
	    TEST: {},
	    __GLOBAL_DEFAULTS: arg_GLOBAL_DEFAULTS,

	    __INIT: function() {
	        self.__RESET_GROUP(self.TEST, self.__GLOBAL_DEFAULTS.TEST);
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