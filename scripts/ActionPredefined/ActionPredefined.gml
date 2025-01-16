// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function Action_Predefined_Move_In_Radius(arg_inRadius, autoStart = true) 
{
	var mySelectorActionList = ds_list_create();
	ds_list_add(mySelectorActionList, Action_Selector_All_Active_Chars());
	ds_list_add(mySelectorActionList, Action_Selector_Without_Char_In_Radius(arg_inRadius));
	
	var actionProcessor = ActionProcessorClass(Action_Processor_Move);

	var selectorManager = MySelectorActionManagerClass(mySelectorActionList);
	var _actionClass = ActionClass(selectorManager, actionProcessor);

	//var closedAction = function(arg_actionClass) {
	//	var closedFunction = {
	//		__actionClass: arg_actionClass,
	//		toReturn: function(_self) {
	//			if(!helper_struct_is_undefined_or_empty(__actionClass) ) {
	//				__actionClass.execute(_self);
	//			}
	//		}
	//	}
	//	return closedFunction.toReturn;
	//}
	
	return _actionClass;
}