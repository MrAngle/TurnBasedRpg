global.LAYERS = noone;

global.LAYERS_BACKGROUND_DEPTH_DIFF = 1;

function init_layers() {
	var GAME_CURSOR_DEPTH = -1000;
    var GUI_GAME_MENU_DEPTH = 50;
    var GUI_MENU_DEPTH = GUI_GAME_MENU_DEPTH + 50;
	var SELECTORS_DEPTH = GUI_MENU_DEPTH + 50;
    var ATTACKS_DEPTH = SELECTORS_DEPTH + 50;
    var CHARACTERS_DEPTH = ATTACKS_DEPTH + 1000;
    var DECORATION_DEPTH = CHARACTERS_DEPTH + 1000;
    var GROUND_DEPTH = DECORATION_DEPTH + 1000;
    var MANAGERS_DEPTH = GROUND_DEPTH + 1000;
    var BACKGROUND_DEPTH = MANAGERS_DEPTH + 1000;

    global.LAYERS = {
		game_cursor: {
            id: layer_create(GAME_CURSOR_DEPTH),
            depth: GAME_CURSOR_DEPTH
        },
        gui_game_menu: {
            id: layer_create(GUI_GAME_MENU_DEPTH),
            depth: GUI_GAME_MENU_DEPTH
        },
        gui_menu: {
            id: layer_create(GUI_MENU_DEPTH),
            depth: GUI_MENU_DEPTH
        },
		selectors: {
            id: layer_create(SELECTORS_DEPTH),
            depth: SELECTORS_DEPTH
        },
        attacks: {
            id: layer_create(ATTACKS_DEPTH),
            depth: ATTACKS_DEPTH
        },
        characters: {
            id: layer_create(CHARACTERS_DEPTH),
            depth: CHARACTERS_DEPTH
        },
        decoration: {
            id: layer_create(DECORATION_DEPTH),
            depth: DECORATION_DEPTH
        },
        ground: {
            id: layer_create(GROUND_DEPTH),
            depth: GROUND_DEPTH,
			desert_depth: GROUND_DEPTH,
			depth_period: 5
        },
        managers: {
            id: layer_create(MANAGERS_DEPTH),
            depth: MANAGERS_DEPTH
        },
        background: {
            id: layer_create(BACKGROUND_DEPTH),
            depth: BACKGROUND_DEPTH
        },
		
		
    };

    // Debug: Wyświetlenie informacji o utworzonych warstwach
    show_debug_message("Warstwy zostały zainicjalizowane w global.LAYERS.");
}