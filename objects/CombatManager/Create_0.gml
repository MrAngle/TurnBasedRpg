player_chars = [];
enemy_chars = [];
neutral_chars = [];

combatMapHolder = combat_map_generator_generate_random_desert_map(10, 13);
combatMapManager = MyCombatMapManager(combatMapHolder);
global.myCombatMapHolder = combatMapHolder;
global.myCombatMapManager = combatMapManager;

global.myCombatMapHolder.show_tiles();

var character = instance_create_layer(0, 0, global.LAYERS_INSTANCES, ObjNecro1);
var menuTooltipManager = instance_create_layer(0, 0, global.LAYERS_INSTANCES, MenuToolTipManager);
global.myCombatMapHolder.get_tile(5, 5).set_tile_auto_type(character);
//my_map_show_map();

var combatCharacterListClass = CombatCharacterListClass(global.myCombatMapManager.get_all_characters_on_map())

var value = combatCharacterListClass.get_characters(CombatCharacterIndex.PLAYER);
var value2 = global.myCombatMapManager.get_all_characters_on_map();
