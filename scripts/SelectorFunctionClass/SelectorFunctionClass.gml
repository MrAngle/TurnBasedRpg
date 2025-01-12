//function SelectorFunctionClass(_myMapTile, _SELECTOR_TYPE_ENUM) {
//    var map_SelectorFunctionClass = {
//        __selector_myMapTile: _myMapTile, // myMapTile
//        __selector_type: _SELECTOR_TYPE_ENUM, // SELECTOR_TYPE_ENUM
//        __hexFieldSelectorDecoration: noone, // HexFieldSelectorDecoration
        
//		// constructor
//		__init_SelectorFunctionClass: function() {
//			__hexFieldSelectorDecoration = 
//				HexFieldSelectorDecorationFactory(__selector_myMapTile, __selector_type)
//        },
		
//		        // Funkcja usuwania
//        destroy: function() {
//            if (instance_exists(self.__hexFieldSelectorDecoration)) {
//                instance_destroy(self.__hexFieldSelectorDecoration);
//            }
//            self.__hexFieldSelectorDecoration = noone;
//            self.__selector_myMapTile = noone;
//            self.__selector_type = undefined;
//        }

//    };
	
//	map_SelectorFunctionClass.__init_SelectorFunctionClass();
//	return map_SelectorFunctionClass;
//}