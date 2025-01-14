menuTooltipManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuToolTipManager);
menuCharsTurnManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuCharsTurnManager);
menuSelectedCharManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuSelectedCharManager);

global.COMBAT_GLOBALS.MENU.TOOLTIP = menuTooltipManager;
global.COMBAT_GLOBALS.MENU.CHARS_TURN = menuCharsTurnManager;
global.COMBAT_GLOBALS.MENU.SELECTED_CHAR = menuSelectedCharManager;