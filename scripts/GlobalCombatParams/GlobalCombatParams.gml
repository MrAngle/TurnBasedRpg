
//global.COMBAT_GLOBALS.MANAGERS.MENU_SELECTED_CHAR
// Funkcja inicjalizacji domyślnych wartości
global.__INIT_COMBAT_GLOBAL = function() {
	var vTILE_RADIUS = 128;
	var vALARM_PERIOD_MINIMUM = 1;
	var defONClickEvent = function(_self) { // Remember to pass reference
		show_debug_message("tile_selector_on_click_element is not set for object: " + string(_self.id));
	}

	var GLOBAL_DEFAULTS = new COMBAT_GLOBALS_STRUCT(defONClickEvent, vALARM_PERIOD_MINIMUM, vTILE_RADIUS);
    
	/// @type {Struct.COMBAT_GLOBALS_STRUCT}
    global.COMBAT_GLOBALS = __GLOBALS_STRUCT(GLOBAL_DEFAULTS);
};

/// @returns {Struct.COMBAT_GLOBALS_STRUCT}
function COMBAT_GLOBALS_STRUCT(arg_onDefaultClickEvent, arg_defaultAlarmPeriodMin, arg_defTileRadius) constructor {
	MANAGERS = {
		COMBAT_MAP: noone, // MyCombatMapManager  // global.myCombatMapManager
		COMBAT_TURN: noone, // CombatTurnManager
		SELECTOR: noone, // SelectorManager
		ACTION_SELECTOR: noone // ActionSelectorManager
	}
	MENU = {
		TOOLTIP: noone, // MenuToolTipManager
		CHARS_TURN: noone, // MenuCharsTurnManager (obj)
		SELECTED_CHAR: noone, // MenuSelectedCharManager
	}
	MAP = {
		/// @type {Struct.__MyCombatMapHolder}
		MAP_HOLDER: noone, // MyCombatMapHolder
		SELECTED_TILE: noone, // STRUCT MyMapTile
		SELECTED_CHARACTER: noone, // Object abst_combat_character
		HOVERED_TILE: noone // Struct MyMapTile
	}
	ACTION_PREPARATION = {
		CURRENT_CHARACTER_TO_PREPARE: noone // abst_combat_character
	}
	SELECTOR = {
		ON_CLICK_EVENT_FUNCTION: arg_onDefaultClickEvent
	}
	STORE = {
		COMBAT_CHARACTERS_HOLDER: noone // CombatCharactersHolderClass
	}
	ACTION = {
		PROCESSING: false,
		/// @type {Id.Instance.AbstTurnEntity}
		CURRENT_INVOKER_TURN_ENTITY_OBJ: noone,
		/// @type {Enum.ACTION_TURN_STATE_ENUM}
		CURRENT_TURN_STATE_ENUM: ACTION_TURN_STATE_ENUM.CALCULATE_NEXT_TURN_ENTITY,
		/// @type {Struct.__ActionResolvedStruct}
		CURRENT_TURN_ACTION_RESOLVED_STRUCT: noone, //
		/// @type {Enum.ACTION_INTENT_ENUM}
		CURRENT_TURN_ACTION_INTENT_ENUM: noone, //
		/// @type {number}
		CURRENT_MIN_ACTION_POINTS: 0 // 
	}
	EVENT = {
		CLICK : {
			INPUT_LAST_TRIGGER: noone,
			INPUT_LOCKED_THIS_FRAME: noone
		}
	}
	COMBAT_PROPERTIES = {
		//END_TURN_BUTTON: noone // CombatTurnEndTurnButton
	}
	ALARM  = {
		PERIOD_MINIMUM: arg_defaultAlarmPeriodMin, // MINIMUM PERIOD BETWEEN ALARMS 
		COMBAT_MANAGER_INIT_DELAY: arg_defaultAlarmPeriodMin, // MINIMUM PERIOD BETWEEN ALARMS
	}
	METRICS = {
		SELECTORS_COUNT: 0,
		TILE_COUNT: 0,
		//TERRAIN_COUNT: 0,
		//CHARACTERS_COUNT: 0
	}

	VISUAL_PROPERTIES = {
		TILE_RADIUS: arg_defTileRadius, // Promień heksagonu (wysokość / 2)
		TILE_WIDTH: sqrt(3) * arg_defTileRadius, // Szerokość heksagonu
		TILE_HEIGHT: 2 * arg_defTileRadius // Wysokość heksagonu
	}
}


function __GLOBALS_STRUCT(arg_GLOBAL_DEFAULTS) {
	var globalsStruct = {
	    MANAGERS: {},
		MENU: {},
		MAP: {},
		ACTION_PREPARATION: {},
		SELECTOR: {},
	    STORE: {},
	    ACTION: {},
	    EVENT: {},
	    COMBAT_PROPERTIES: {},
		ALARM: {},
		METRICS: {},
	    VISUAL_PROPERTIES: {},
	    __GLOBAL_DEFAULTS: arg_GLOBAL_DEFAULTS,

	    __INIT: function() {
	        self.__RESET_GROUP(self.MANAGERS, self.__GLOBAL_DEFAULTS.MANAGERS);
			self.__RESET_GROUP(self.MENU, self.__GLOBAL_DEFAULTS.MENU);
			self.__RESET_GROUP(self.MAP, self.__GLOBAL_DEFAULTS.MAP);
			self.__RESET_GROUP(self.ACTION_PREPARATION, self.__GLOBAL_DEFAULTS.ACTION_PREPARATION);
	        self.__RESET_GROUP(self.SELECTOR, self.__GLOBAL_DEFAULTS.SELECTOR);
	        self.__RESET_GROUP(self.STORE, self.__GLOBAL_DEFAULTS.STORE);
	        self.__RESET_GROUP(self.ACTION, self.__GLOBAL_DEFAULTS.ACTION);
	        self.__RESET_GROUP(self.EVENT, self.__GLOBAL_DEFAULTS.EVENT);
	        self.__RESET_GROUP(self.COMBAT_PROPERTIES, self.__GLOBAL_DEFAULTS.COMBAT_PROPERTIES);
	        self.__RESET_GROUP(self.ALARM, self.__GLOBAL_DEFAULTS.ALARM);
	        self.__RESET_GROUP(self.METRICS, self.__GLOBAL_DEFAULTS.METRICS);
	        self.__RESET_GROUP(self.VISUAL_PROPERTIES, self.__GLOBAL_DEFAULTS.VISUAL_PROPERTIES);
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


//global.initialize_defaults();
//global.initialize_globals();

// Funkcja inicjalizacji globalnej struktury zarządzającej
//global.initialize_global_manager = function() {
//    global.manager = {
//        managers: {},
//        store: {},
//        combat_properties: {},
//        visual_properties: {},

//        reset: function() {
//            __reset_group(self.managers, global.defaults.managers);
//            __reset_group(self.store, global.defaults.store);
//            __reset_group(self.combat_properties, global.defaults.combat_properties);
//            __reset_group(self.visual_properties, global.defaults.visual_properties);
//        },
		
//		__reset_group: function(global_variable, default_values) {
//		    var keys = variable_struct_get_names(default_values);
//		    for (var i = 0; i < array_length(keys); i++) {
//		        var key = keys[i];
//		        variable_struct_set(global_variable, key, variable_struct_get(default_values, key));
//		    }
//		}
//    };
//};

//global.reset_all_globals = function() {
//    reset_group(global.managers, global.defaults.managers);
//    reset_group(global.store, global.defaults.store);
//    reset_group(global.combat_properties, global.defaults.combat_properties);
//    reset_group(global.visual_properties, global.defaults.visual_properties);
//};



// Funkcja resetu grupy zmiennych
//function reset_group(global_variable, default_values) {
//    var keys = variable_struct_get_names(default_values);
//    for (var i = 0; i < array_length(keys); i++) {
//        var key = keys[i];
//        variable_struct_set(global_variable, key, variable_struct_get(default_values, key));
//    }
//}

// Funkcja inicjalizacji grup zmiennych globalnych
//global.initialize_globals = function() {
//    global.managers = {};
//    global.store = {};
//    global.combat_properties = {};
//    global.visual_properties = {};
//};

//// Centralna funkcja resetu wszystkich zmiennych
//global.reset_all_globals = function() {
//    reset_group(global.managers, global.defaults.managers);
//    reset_group(global.store, global.defaults.store);
//    reset_group(global.combat_properties, global.defaults.combat_properties);
//    reset_group(global.visual_properties, global.defaults.visual_properties);
//};

// Inicjalizacja domyślnych wartości i zmiennych globalnych

