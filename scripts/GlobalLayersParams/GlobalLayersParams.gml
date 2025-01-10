global.LAYERS = noone;

function init_layers() {
    var GUI_GAME_MENU_DEPTH = 50;
    var GUI_MENU_DEPTH = GUI_GAME_MENU_DEPTH + 50;
    var ATTACKS_DEPTH = GUI_MENU_DEPTH + 1000;
    var CHARACTERS_DEPTH = ATTACKS_DEPTH + 1000;
    var DECORATION_DEPTH = CHARACTERS_DEPTH + 1000;
    var GROUND_DEPTH = DECORATION_DEPTH + 1000;
    var MANAGERS_DEPTH = GROUND_DEPTH + 1000;
    var BACKGROUND_DEPTH = MANAGERS_DEPTH + 1000;

    global.LAYERS = {
        gui_game_menu: {
            id: layer_create(GUI_GAME_MENU_DEPTH),
            depth: GUI_GAME_MENU_DEPTH
        },
        gui_menu: {
            id: layer_create(GUI_MENU_DEPTH),
            depth: GUI_MENU_DEPTH
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
			depth_period: 2
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