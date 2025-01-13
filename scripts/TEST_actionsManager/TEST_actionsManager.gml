// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function TEST_actionsManager() 
{
	return {
	    __queue: [], // Tablica przechowująca zadania
		__index: 0,
		__is_finished: false,
	    add: function(func, nextActionTimeInFrames = 1) {
	        var action = {
	            __func: func,					// Funkcja do wykonania
	            __delay: nextActionTimeInFrames, // Czas opóźnienia w klatkach
	        };
	        array_push(self.__queue, action);
	    },
	    process: function() {
			if(__is_finished) {
				return;
			}
			
	        if (array_length(self.__queue) > 0) {
	            var action = self.__queue[__index];
	            action.__func();         // Wykonaj funkcję
	                
				if(__index >= array_length(self.__queue) - 1) {
					__is_finished = true;
				} else {
					__index = __index + 1;
				}
	        }
	    },
		
		getNextActionTimeInFrames: function() {
			var action = self.__queue[__index];
			return action.__delay;
		},
		
	    clear: function() {
	        self.__queue = []; // Wyczyść kolejkę
	    },
	    size: function() {
	        return array_length(self.__queue); // Zwraca liczbę elementów w kolejce
	    }
	};
}
