// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function ActionClass(arg_MySelectorActionManagerClass, arg_ActionProcessorClass) 
{
	var _actionClass = {
		__mySelectorActionManagerClass: arg_MySelectorActionManagerClass,  //MySelectorActionManagerClass
		__actionProcessorClass: arg_ActionProcessorClass, // ActionProcessorClass
		__isActive: true,
		
		start: function(_self) {
			__mySelectorActionManagerClass.start(self)
			global.COMBAT_GLOBALS.SELECTOR.ON_CLICK_EVENT_FUNCTION = self.execute;
		},
		
		execute: function(_self) {
			if(__isActive) {
				__mySelectorActionManagerClass.execute(_self);
			
				if(__mySelectorActionManagerClass.__selector_actions_finished == true) {
					__actionProcessorClass.execute(_self, __mySelectorActionManagerClass.__selector_MySelectorActions);
				
					__mySelectorActionManagerClass.destroy();
					__isActive = false;
				}
			}
		}
	}
	
	return _actionClass;
}