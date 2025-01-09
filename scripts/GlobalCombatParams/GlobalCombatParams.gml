// Managers:
global.myCombatMapManager = noone; // MyCombatMapManager
global.myCombatTurnManager = noone; // CombatTurnManager
global.myMenuTooltipManager = noone;
global.myMenuCharsTurnManager = noone; // MenuCharsTurnManager (obj)

// Store:
global.myCombatMapHolder = noone; // MyCombatMapHolder
global.myCombatCharactersHolderClass = noone; // CombatCharactersHolderClass

// General Combat properties:
global.myActiveTile = noone; // Struct MyMapTile
global.myActiveHoveredTile = noone; // Struct MyMapTile


// Visual properties:
global.__map_tile_radius = 128; // Promień heksagonu (wysokość / 2)
//global.__map_tile_width = 214 - 1; // Szerokość heksagonu
global.__map_tile_width = sqrt(3) * __map_tile_radius; // Szerokość heksagonu
//var w = sqrt(3) * r; // Szerokość heksagonu
global.__map_tile_height = 2 * global.__map_tile_radius; // Wysokość heksagonu