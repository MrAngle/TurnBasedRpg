// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function ActionProcessorClass(arg_ActionExecutorFunc) 
{
	var _actionProcessor = {
		__actionExecutorFunc: arg_ActionExecutorFunc,
		
		execute: function(_self, __invoker_char, __selector_MySelectorActions) {
			__actionExecutorFunc(_self, __invoker_char, __selector_MySelectorActions);
		}
	}
	
	return _actionProcessor;
}