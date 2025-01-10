player_chars = [];
enemy_chars = [];
neutral_chars = [];

init_layers();

combatMapHolder = combat_map_generator_generate_random_desert_map(10, 13);
combatMapManager = MyCombatMapManager(combatMapHolder);
menuTooltipManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuToolTipManager);
menuBottomManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuBottomManager);
menuCharsTurnManager = instance_create_layer(0, 0, global.LAYERS.gui_menu.id, MenuCharsTurnManager);
global.myCombatMapHolder = combatMapHolder;
global.myCombatMapManager = combatMapManager;
global.myMenuTooltipManager = menuTooltipManager;
global.myMenuCharsTurnManager = menuCharsTurnManager;

global.myCombatMapHolder.show_tiles();

var character = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);
var character2 = instance_create_layer(0, 0, global.LAYERS.characters.id, ObjNecro1);

global.myCombatMapHolder.get_tile(5, 5).set_tile_auto_type(character);
global.myCombatMapHolder.get_tile(3, 5).set_tile_auto_type(character2);


combatCharactersHolderClass = CombatCharactersHolderClass(global.myCombatMapManager.get_all_characters_on_map())
global.myCombatCharactersHolderClass = combatCharactersHolderClass;
combatTurnManager = instance_create_layer(0, 0, global.LAYERS.managers.id, CombatTurnManager);
global.myCombatTurnManager = combatTurnManager;





my_start_combat = function() {
	combatTurnManager.switch_to_player_turn();
}

my_start_combat();