// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
function Action_Predefined_Move_In_Radius(arg_invoker_char, arg_inRadius, autoStart = true) 
{
	var mySelectorActionList = ds_list_create();
	
	ds_list_add(mySelectorActionList, Action_Selector_Without_Char_In_Radius(arg_invoker_char, arg_inRadius));
	
	var actionProcessor = ActionProcessorClass(Action_Processor_Move());

	var selectorManager = MySelectorActionManagerClass(mySelectorActionList);
	var _actionClass = ActionClass(arg_invoker_char, selectorManager, actionProcessor);

	return _actionClass;
}

function Action_Predefined_Select_Character_To_Prepare_Turn() 
{
	// SELECTOR
	var mySelectorActionList = ds_list_create();
	ds_list_add(mySelectorActionList, Action_Selector_All_Active_Chars_Without_Selected_Actions());
	var selectorManager = MySelectorActionManagerClass(mySelectorActionList);
	
	// ACTION PROCESSOR
	var actionProcessor = ActionProcessorClass(Action_Processor_Make_Turn_Active_For_Char());
	
	// ACTION
	var _actionClass = ActionClass(noone, selectorManager, actionProcessor);

	return _actionClass;
}