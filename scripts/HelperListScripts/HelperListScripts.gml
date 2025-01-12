// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

enum LIST_STORE_REPLACE_STRATEGY {
	REPLACE_FIRST_WHEN_MAX,
	REPLACE_LAST_WHEN_MAX,
	IGNORE_WHEN_MAX
}

function helper_add_function_for_list(_dsListToUse, _maxElements, _LIST_STORE_REPLACE_STRATEGY) {
    switch (self.__selector_store_strategy) {
        case LIST_STORE_REPLACE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
            return function(_SelectorTileClass) {
                var currentCount = ds_list_size(self.__selector_SelectorTileClass);
                if (currentCount >= self.__selector_maxElements) {
                    // Usuń pierwszy element przed zastąpieniem
                    ds_list_delete(self.__selector_SelectorTileClass, 0);
                }
                ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
            };

        case LIST_STORE_REPLACE_STRATEGY.REPLACE_LAST_WHEN_MAX:
            return function(_SelectorTileClass) {
                var currentCount = ds_list_size(self.__selector_SelectorTileClass);
                if (currentCount >= self.__selector_maxElements) {
                    // Usuń ostatni element przed zastąpieniem
                    ds_list_delete(self.__selector_SelectorTileClass, currentCount - 1);
                }
                ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
            };

        case LIST_STORE_REPLACE_STRATEGY.IGNORE_WHEN_MAX:
            return function(_SelectorTileClass) {
                var currentCount = ds_list_size(self.__selector_SelectorTileClass);
                if (currentCount < self.__selector_maxElements) {
                    ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
                }
                // W przeciwnym razie nic nie robimy
            };

        default:
            return function(_SelectorTileClass) {
                show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
            };
    }
}


function helper_add_method() {
	switch (self.__selector_store_strategy) {
		case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
		    return function(_SelectorTileClass) {
		        var currentCount = array_length(self.__selector_SelectorTileClass);
		        if (currentCount >= self.__selector_maxElements) {
		            // Zastępujemy pierwszy element
		            self.__selector_SelectorTileClass[0] = _SelectorTileClass;
		        } else {
		            array_push(self.__selector_SelectorTileClass, _SelectorTileClass);
		        }
		    };

		case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
		    return function(_SelectorTileClass) {
		        var currentCount = array_length(self.__selector_SelectorTileClass);
		        if (currentCount >= self.__selector_maxElements) {
		            // Zastępujemy ostatni element
		            self.__selector_SelectorTileClass[currentCount - 1] = _SelectorTileClass;
		        } else {
		            array_push(self.__selector_SelectorTileClass, _SelectorTileClass);
		        }
		    };

		case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
		    return function(_SelectorTileClass) {
		        var currentCount = array_length(self.__selector_SelectorTileClass);
		        if (currentCount < self.__selector_maxElements) {
		            array_push(self.__selector_SelectorTileClass, _SelectorTileClass);
		        }
		        // W przeciwnym razie nic nie robimy
		    };

		default:
		    return function(_SelectorTileClass) {
		        show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
		    };
	}
}
		
	//	__can_add_selector_tile: function() {
	//	    var currentCount = array_length(self.__selector_SelectorTileClass);

	//	    switch (self.__selector_store_strategy) {
	//	        case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
	//	            // W strategii zastępowania zawsze można dodać element (zastąpienie)
	//	            return true;

	//	        case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
	//	            // W strategii zastępowania zawsze można dodać element (zastąpienie)
	//	            return true;

	//	        case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
	//	            // W strategii ignorowania, dodanie jest możliwe tylko, gdy liczba elementów jest mniejsza od maksymalnej
	//	            return currentCount < self.__selector_maxElements;

	//	        default:
	//	            // Nieznana strategia, zwracamy false jako domyślną wartość
	//	            show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
	//	            return false;
	//	    }
	//	},
		
	//	__get_replaced_tile: function(_SelectorTileClass) {
	//	    var currentCount = array_length(self.__selector_SelectorTileClass);
    
	//	    switch (self.__selector_store_strategy) {
	//	        case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
	//	            if (currentCount >= self.__selector_maxElements) {
	//	                // Pierwszy element zostanie zastąpiony
	//	                return self.__selector_SelectorTileClass[0];
	//	            }
	//	            break;

	//	        case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
	//	            if (currentCount >= self.__selector_maxElements) {
	//	                // Ostatni element zostanie zastąpiony
	//	                return self.__selector_SelectorTileClass[currentCount - 1];
	//	            }
	//	            break;

	//	        case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
	//	            if (currentCount >= self.__selector_maxElements) {
	//	                // Nic nie zostanie zastąpione
	//	                return undefined;
	//	            }
	//	            break;

	//	        default:
	//	            show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
	//	            return undefined;
	//	    }

	//	    // Jeśli dodanie jest możliwe bez zastąpienia, zwracamy undefined
	//	    return undefined;
	//	}
    //};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//		__get_selector_store_function_add_SelectorTileClass: function() {
	//	    switch (self.__selector_store_strategy) {
	//	        case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
	//	            return function(_SelectorTileClass) {
	//	                var currentCount = ds_list_size(self.__selector_SelectorTileClass);
	//	                if (currentCount >= self.__selector_maxElements) {
	//	                    // Zastępujemy pierwszy element
	//	                    self.__selector_SelectorTileClass[0] = _SelectorTileClass;
	//	                } else {
	//	                    ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
	//	                }
	//	            };

	//	        case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
	//	            return function(_SelectorTileClass) {
	//	                var currentCount = ds_list_size(self.__selector_SelectorTileClass);
	//	                if (currentCount >= self.__selector_maxElements) {
	//	                    // Zastępujemy ostatni element
	//	                    self.__selector_SelectorTileClass[currentCount - 1] = _SelectorTileClass;
	//	                } else {
	//	                    ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
	//	                }
	//	            };

	//	        case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
	//	            return function(_SelectorTileClass) {
	//	                var currentCount = ds_list_size(self.__selector_SelectorTileClass);
	//	                if (currentCount < self.__selector_maxElements) {
	//	                    ds_list_add(self.__selector_SelectorTileClass, _SelectorTileClass);
	//	                }
	//	                // W przeciwnym razie nic nie robimy
	//	            };

	//	        default:
	//	            return function(_SelectorTileClass) {
	//	                show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
	//	            };
	//	    }
	//	},
		
	//	__can_add_selector_tile: function() {
	//	    var currentCount = ds_list_size(self.__selector_SelectorTileClass);

	//	    switch (self.__selector_store_strategy) {
	//	        case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
	//	            // W strategii zastępowania zawsze można dodać element (zastąpienie)
	//	            return true;

	//	        case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
	//	            // W strategii zastępowania zawsze można dodać element (zastąpienie)
	//	            return true;

	//	        case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
	//	            // W strategii ignorowania, dodanie jest możliwe tylko, gdy liczba elementów jest mniejsza od maksymalnej
	//	            return currentCount < self.__selector_maxElements;

	//	        default:
	//	            // Nieznana strategia, zwracamy false jako domyślną wartość
	//	            show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
	//	            return false;
	//	    }
	//	},
		
	//	__get_replaced_tile: function(_SelectorTileClass) {
	//	    var currentCount = ds_list_size(self.__selector_SelectorTileClass);
    
	//	    switch (self.__selector_store_strategy) {
	//	        case SELECTOR_STORE_STRATEGY.REPLACE_FIRST_WHEN_MAX:
	//	            if (currentCount >= self.__selector_maxElements) {
	//	                // Pierwszy element zostanie zastąpiony
	//	                return self.__selector_SelectorTileClass[0];
	//	            }
	//	            break;

	//	        case SELECTOR_STORE_STRATEGY.REPLACE_LAST_WHEN_MAX:
	//	            if (currentCount >= self.__selector_maxElements) {
	//	                // Ostatni element zostanie zastąpiony
	//	                return self.__selector_SelectorTileClass[currentCount - 1];
	//	            }
	//	            break;

	//	        case SELECTOR_STORE_STRATEGY.IGNORE_WHEN_MAX:
	//	            if (currentCount >= self.__selector_maxElements) {
	//	                // Nic nie zostanie zastąpione
	//	                return undefined;
	//	            }
	//	            break;

	//	        default:
	//	            show_debug_message("Unknown strategy: " + string(self.__selector_store_strategy));
	//	            return undefined;
	//	    }

	//	    // Jeśli dodanie jest możliwe bez zastąpienia, zwracamy undefined
	//	    return undefined;
	//	}
    //};