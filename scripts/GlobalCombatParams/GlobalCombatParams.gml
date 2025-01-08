global.myCombatMapHolder = noone; // MyCombatMapHolder
global.myCombatMapManager = noone; // MyCombatMapManager

global.__map_tile_radius = 128 - 1; // Promień heksagonu (wysokość / 2)
global.__map_tile_width = 214 - 1; // Szerokość heksagonu
//var w = sqrt(3) * r; // Szerokość heksagonu
global.__map_tile_height = 2 * global.__map_tile_radius; // Wysokość heksagonu

global.myActiveTile = noone; // Struct MyMapTile
global.myActiveHoveredTile = noone; // Struct MyMapTile
