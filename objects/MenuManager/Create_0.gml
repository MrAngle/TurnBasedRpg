menuTooltipManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuToolTipManager);
menuCharsTurnManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuCharsTurnManager);
menuSelectedCharManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuSelectedCharManager);

global.myMenuTooltipManager = menuTooltipManager;
global.myMenuCharsTurnManager = menuCharsTurnManager;
global.myMenuSelectedCharManager = menuSelectedCharManager;