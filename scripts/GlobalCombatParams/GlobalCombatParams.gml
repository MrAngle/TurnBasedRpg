// Managers:
global.myCombatMapManager = noone; // MyCombatMapManager
global.myCombatTurnManager = noone; // CombatTurnManager
global.myMenuTooltipManager = noone;
global.myMenuCharsTurnManager = noone; // MenuCharsTurnManager (obj)
global.myMenuSelectedCharManager = noone;
global.mySelectorManager = noone; // SelectorManager

// Store:
global.myCombatMapHolder = noone; // MyCombatMapHolder
global.myCombatCharactersHolderClass = noone; // CombatCharactersHolderClass

// General Combat properties:
global.mySelectedTile = noone; // Struct MyMapTile
global.mySelectedCharacter = noone; // Object abst_combat_character
global.myActiveTile = noone; // Struct MyMapTile
global.myActiveHoveredTile = noone; // Struct MyMapTile


// Visual properties:
global.__map_tile_radius = 128; // Promień heksagonu (wysokość / 2)
//global.__map_tile_width = 214 - 1; // Szerokość heksagonu
//global.__map_tile_width = 222; // Szerokość heksagonu
global.__map_tile_width = (sqrt(3) * global.__map_tile_radius); // Szerokość heksagonu
//var w = sqrt(3) * r; // Szerokość heksagonu
global.__map_tile_height = 2 * global.__map_tile_radius; // Wysokość heksagonu







//global.TEST_ACTIVE = true;

//global.TEST_PASSED = true;



// Funkcja inicjalizacji domyślnych wartości
global.__INIT_COMBAT_GLOBAL = function() {
    var GLOBAL_DEFAULTS = {
        MANAGERS: {
            COMBAT_MAP: noone,
            COMBAT_TURN: noone,
            MENU_TOOLTIP: noone,
            MENU_CHARS_TURN: noone,
            MENU_SELECTED_CHAR: noone,
            SELECTOR: noone
        },
        STORE: {
            COMBAT_MAP_HOLDER: noone,
            COMBAT_CHARACTERS_HOLDER: noone
        },
        COMBAT_PROPERTIES: {
            SELECTED_TILE: noone,
            SELECTED_CHARACTER: noone,
            ACTIVE_TILE: noone,
            ACTIVE_HOVERED_TILE: noone
        },
        VISUAL_PROPERTIES: {
            TILE_RADIUS: 128,
            TILE_WIDTH: sqrt(3) * 128,
            TILE_HEIGHT: 2 * 128
        }
    };
    
    global.COMBAT_GLOBALS = __GLOBALS_STRUCT(GLOBAL_DEFAULTS);
};


function __GLOBALS_STRUCT(arg_GLOBAL_DEFAULTS) {
	var globalsStruct = {
	    MANAGERS: {},
	    STORE: {},
	    COMBAT_PROPERTIES: {},
	    VISUAL_PROPERTIES: {},
	    __GLOBAL_DEFAULTS: arg_GLOBAL_DEFAULTS,

	    __INIT: function() {
	        self.__RESET_GROUP(self.MANAGERS, self.__GLOBAL_DEFAULTS.MANAGERS);
	        self.__RESET_GROUP(self.STORE, self.__GLOBAL_DEFAULTS.STORE);
	        self.__RESET_GROUP(self.COMBAT_PROPERTIES, self.__GLOBAL_DEFAULTS.COMBAT_PROPERTIES);
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

