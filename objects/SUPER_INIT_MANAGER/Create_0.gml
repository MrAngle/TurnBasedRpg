global.__INIT_COMBAT_GLOBAL();
init_layers();

if(global.GAME_GLOBALS.TEST.ACTIVE) {
	instance_create_layer(0, 0, global.LAYERS.managers.id, TEST_SelectorMove);
}
instance_create_layer(0, 0, global.LAYERS.managers.id, CombatManager);