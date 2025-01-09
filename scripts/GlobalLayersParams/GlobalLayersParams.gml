// INSTANCES
global.LAYERS_GUI_GAME_MENU = "GUI_Game_Menu";	global.GUI_GAME_MENU_DEPTH = 50;
global.LAYERS_GUI_MENU = "GUI_Menu";			global.GUI_MENU_DEPTH = global.GUI_GAME_MENU_DEPTH + 50;
global.LAYERS_ATTACKS = "Attacks";				global.ATTACKS_DEPTH = global.GUI_MENU_DEPTH + 1000;
global.LAYERS_CHARACTERS = "Characters";		global.CHARACTERS_DEPTH = global.ATTACKS_DEPTH + 1000;
global.LAYERS_DECORATION = "Decoration";		global.DECORATION_DEPTH = global.CHARACTERS_DEPTH + 1000;
global.LAYERS_GROUND = "Ground";				global.GROUND_DEPTH = global.DECORATION_DEPTH + 1000;
global.LAYERS_MANAGERS = "Managers";			global.MANAGERS_DEPTH = global.GROUND_DEPTH + 1000;

// BACKGROUND
global.LAYERS_BACKGROUND = "Background";		global.BACKGROUND_DEPTH = global.MANAGERS_DEPTH + 1000;

global.LAYERS_GROUND_DEPTH_PERIOD = 2;	


//global.INSTANCES_DEPTH = 2000;

// Funkcja inicjalizująca warstwy
function init_layers() {
    // Tworzenie warstw INSTANCES
    var gui_game_menu_layer = layer_create(global.GUI_GAME_MENU_DEPTH);
    //layer_name(gui_game_menu_layer, global.LAYERS_GUI_GAME_MENU);

    var gui_menu_layer = layer_create(global.GUI_MENU_DEPTH);
    //layer_name(gui_menu_layer, global.LAYERS_GUI_MENU);

    var attacks_layer = layer_create(global.ATTACKS_DEPTH);
    //layer_name(attacks_layer, global.LAYERS_ATTACKS);

    var characters_layer = layer_create(global.CHARACTERS_DEPTH);
    //layer_name(characters_layer, global.LAYERS_CHARACTERS);

    var decoration_layer = layer_create(global.DECORATION_DEPTH);
    //layer_name(decoration_layer, global.LAYERS_DECORATION);

    var ground_layer = layer_create(global.GROUND_DEPTH);
    //layer_name(ground_layer, global.LAYERS_GROUND);

    var managers_layer = layer_create(global.MANAGERS_DEPTH);
    //layer_name(managers_layer, global.LAYERS_MANAGERS);

    // Tworzenie warstwy BACKGROUND
    var background_layer = layer_create(global.BACKGROUND_DEPTH);
    //layer_name(background_layer, global.LAYERS_BACKGROUND);

    // Opcjonalnie: Zapisanie identyfikatorów warstw w zmiennych globalnych
	global.LAYER_GUI_GAME_MENU = gui_game_menu_layer;
	global.LAYER_GUI_MENU = gui_menu_layer;
	global.LAYER_ATTACKS = attacks_layer;
	global.LAYER_CHARACTERS = characters_layer;
	global.LAYER_DECORATION = decoration_layer;
	global.LAYER_GROUND = ground_layer;
	global.LAYER_MANAGERS = managers_layer;
	global.LAYER_BACKGROUND = background_layer;

    // Debug: Wyświetlenie informacji o utworzonych warstwach
    show_debug_message("Warstwy zostały zainicjalizowane.");
}



// GROUND LAYERS DEPTH

global.LAYERS_GROUND_DESERT_DEPTH = global.GROUND_DEPTH;	