var cols = 13; // Liczba kolumn
var rows = 10; // Liczba wierszy

var combatMapHolder = combat_map_generator_generate_random_desert_map(rows, cols);
var combatMapManager = MyCombatMapManager(combatMapHolder);

global.myCombatMapHolder = combatMapHolder;
global.myCombatMapManager = combatMapManager;

global.myCombatMapHolder.show_tiles();

var character = instance_create_layer(0, 0, global.LAYERS_INSTANCES, obj_necro_1);
global.myCombatMapHolder.get_tile(5, 5).set_tile(character, TileObjectTypeEnum.CHARACTER);
//my_map_show_map();

var value = global.myCombatMapHolder.find_character_in_map(character);
var value2 = global.myCombatMapHolder.find_character_in_map(character);

