// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

enum SELECTOR_TYPE_ENUM {
	HOVER, // ITS use also for layers
	SELECTED,
	ACTIVE,
}

function SelectorTileClass(_myMapTile, _SELECTOR_TYPE_ENUM) {
    var map_SelectedTileClass = {
        __selector_myMapTile: _myMapTile, // myMapTile
        __selector_type: _SELECTOR_TYPE_ENUM, // SELECTOR_TYPE_ENUM
        __hexFieldSelectorDecoration: noone, // HexFieldSelectorDecoration
        
		// constructor
		__init_SelectedTileClass: function() {
			__hexFieldSelectorDecoration = 
				HexFieldSelectorDecorationFactory(__selector_myMapTile, __selector_type)
        },
		
		// Funkcja usuwania
        destroy: function() {
            if (instance_exists(self.__hexFieldSelectorDecoration)) {
                instance_destroy(self.__hexFieldSelectorDecoration);
            }
            self.__hexFieldSelectorDecoration = noone;
            self.__selector_myMapTile = noone;
            self.__selector_type = undefined;
        }

    };
	
	map_SelectedTileClass.__init_SelectedTileClass();
	return map_SelectedTileClass;
}