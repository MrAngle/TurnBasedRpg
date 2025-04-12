//global.myGlobalObjName_None = "None";
//global.myGlobalObjName_Terrain = "Terrain";
//global.myGlobalObjName_Character = "Character";

//global.myGlobalObjName_Necro = "Necro";
//global.myGlobalObjName_Desert = "Desert";


//global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = function(_self) { // Remember to pass reference
//	show_debug_message("tile_selector_on_click_element is not set for object: " + string(_self.id));
//}

//global.COMBAT_GLOBALS.MANAGERS.MENU_SELECTED_CHAR
// Funkcja inicjalizacji domyślnych wartości
global.__INIT_COMBAT_GLOBAL = function() {
	var vTILE_RADIUS = 128;
	var vALARM_PERIOD_MINIMUM = 1;
	var defONClickEvent = function(_self) { // Remember to pass reference
		show_debug_message("tile_selector_on_click_element is not set for object: " + string(_self.id));
	}
	
    var GLOBAL_DEFAULTS = {
        MANAGERS: {
            COMBAT_MAP: noone, // MyCombatMapManager  // global.myCombatMapManager
            COMBAT_TURN: noone, // CombatTurnManager
            SELECTOR: noone, // SelectorManager
			ACTION_SELECTOR: noone // ActionSelectorManager
        },
		MENU: {
			TOOLTIP: noone, // MenuToolTipManager
            CHARS_TURN: noone, // MenuCharsTurnManager (obj)
            SELECTED_CHAR: noone, // MenuSelectedCharManager
		},
		MAP: {
			MAP_HOLDER: noone, // MyCombatMapHolder
			SELECTED_TILE: noone, // STRUCT MyMapTile
            SELECTED_CHARACTER: noone, // Object abst_combat_character
            HOVERED_TILE: noone // Struct MyMapTile
		},
		ACTION_PREPARATION: {
			CURRENT_CHARACTER_TO_PREPARE: noone // abst_combat_character
		},
		SELECTOR: {
			ON_CLICK_EVENT_FUNCTION: defONClickEvent
		},
        STORE: {
            COMBAT_CHARACTERS_HOLDER: noone // CombatCharactersHolderClass
        },
		ACTION: {
			PROCESSING: false,
			CURRENT_TURN_ENTITY: noone,
			CURRENT_TURN_STATE: ActionTurnEnum.CALCULATE_NEXT_TURN_ENTITY,
			CURRENT_TURN_ACTION: noone // 
		},
		EVENT: {
			CLICK : {
				INPUT_LAST_TRIGGER: noone,
				INPUT_LOCKED_THIS_FRAME: noone
			}
		},
        COMBAT_PROPERTIES: {
			//END_TURN_BUTTON: noone // CombatTurnEndTurnButton
        },
		ALARM: {
			PERIOD_MINIMUM: vALARM_PERIOD_MINIMUM, // MINIMUM PERIOD BETWEEN ALARMS 
			COMBAT_MANAGER_INIT_DELAY: vALARM_PERIOD_MINIMUM, // MINIMUM PERIOD BETWEEN ALARMS
		},
		METRICS: {
			SELECTORS_COUNT: 0,
			TILE_COUNT: 0,
			//TERRAIN_COUNT: 0,
			//CHARACTERS_COUNT: 0
		},
        VISUAL_PROPERTIES: {
            TILE_RADIUS: vTILE_RADIUS, // Promień heksagonu (wysokość / 2)
            TILE_WIDTH: sqrt(3) * vTILE_RADIUS, // Szerokość heksagonu
            TILE_HEIGHT: 2 * vTILE_RADIUS // Wysokość heksagonu
        }
    };
    
    global.COMBAT_GLOBALS = __GLOBALS_STRUCT(GLOBAL_DEFAULTS);
};


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

