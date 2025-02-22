// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function ActionClass() 
{
	var _actionClass = {
		__invoker_char: noone, // abst_character
		__mySelectorActionManagerClass: noone,  //MySelectorActionManagerClass
		__actionProcessorClass: noone, // ActionProcessorClass

		__isActive: true,
		
		afterInitConstructor: function(arg_invoker_char, arg_MySelectorActionManagerClass, arg_ActionProcessorClass) {
			__invoker_char = arg_invoker_char; // abst_character
			__mySelectorActionManagerClass = arg_MySelectorActionManagerClass;  //MySelectorActionManagerClass
			__actionProcessorClass = arg_ActionProcessorClass; // ActionProcessorClass
		},
		
		getInvoker: function() {
			return __invoker_char;
		},
		
		start: function(_self) {
			__mySelectorActionManagerClass.start(self)
		},
		
		execute: function(_self) {
			if(__isActive) {
				__mySelectorActionManagerClass.execute(_self);
			
				if(__mySelectorActionManagerClass.__selector_actions_finished == true) {
					__actionProcessorClass.execute(_self, __invoker_char, __mySelectorActionManagerClass.__selector_MySelectorActions);
				
					__mySelectorActionManagerClass.destroy();
					__isActive = false;
				}
			}
		}
	}
	
	return _actionClass;
}


enum AC_EXTRACTOR_ENUM {
	INVOKER,
	LAST_SELECTED_TARGET
}

function ACTION_EXCTRACTOR(arg_Action, arg_AC_EXTRACTOR_ENUM) {
	switch (arg_AC_EXTRACTOR_ENUM) {
        case AC_EXTRACTOR_ENUM.INVOKER:
            return arg_Action.getInvoker();
        case AC_EXTRACTOR_ENUM.LAST_SELECTED_TARGET:
            //return arg_Action.LAST_SELECTED_TARGET; // Pobiera "Last Selected Target"
        default:
            return undefined; // Jeśli wartość nie pasuje, zwraca undefined
    }
}

//function AC_EXCTRACTOR_FUNC(arg_action, arg_AC_EXTRACTOR_ENUM) {
//	var closedFunc = {
//		__action: arg_action,
//		__AC_EXTRACTOR_ENUM: arg_AC_EXTRACTOR_ENUM,
//		toReturn: function() {
//			return ACTION_EXCTRACTOR(__action, __AC_EXTRACTOR_ENUM);
//		}
//	}
//	return closedFunc.toReturn;
//}

function SKILL_EXCTRACTOR(arg_action) {
	var sklEx = {
		__action: arg_action,
		EXCTRACTOR_FUNC: function(arg_AC_EXTRACTOR_ENUM) {
			var closedFunc = {
				__AC_EXTRACTOR_ENUM: arg_AC_EXTRACTOR_ENUM,
				__local_action: __action,
				toReturn: function() {
					return ACTION_EXCTRACTOR(__local_action, __AC_EXTRACTOR_ENUM);
				}
			}
			return closedFunc.toReturn;
		}
	}
	return sklEx;
}