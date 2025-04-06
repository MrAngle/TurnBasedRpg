

function Action_Predefined_Move_In_Radius(arg_invoker_char) 
{
	var _actionClass = ActionClass();
	var sklEx = SKILL_EXCTRACTOR(_actionClass);
	//getValueFunc
	var selectorMovementStats = StatsClass({
				    STAT_TYPE: global.STATISTICS.MOVEMENT,
				    BASE_VALUE_FUNC: VALUE_FUNC(1),
				    SCALING_VALUE_FUNC: VALUE_FUNC(0.5),
				    STAT_SOURCE_FUNC: sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER)
				})
	
	var SELECTOR_PROPERTIES = [
	{
		SKILL_NAME: "Action_Selector_Without_Char_In_Radius",
		STATS: {
			PROPERTIES: [
				selectorMovementStats
			],
			calculateTotal: function() {}
		},
		
		AREA_INCLUDE_FUNCS: [
			AreaFilterClass(
				{
				    AREA_FILTER_BUILDER_FUNC: ActionAreaFilterBuilder_AllTilesInDistance,
				    STATS_CALC_FUNC: selectorMovementStats.getValueFunc(),
				    SOURCE_TILE_FUNC: sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER)
				}
			)
			
				//{
				//}
				//ActionAreaFilterBuilder_AllTilesInDistance(
				//	sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER)
				//)
			//)
		],
		TILE_INCLUDE_RULE_FUNCS: [
			mapTile_filter_element_NOT_contains_character()
		]
	}]
	
	var mySelectorActionList = ds_list_create();
	
	//ds_list_add(mySelectorActionList, MySelectorActionClass(SELECTOR_PROPERTIES[0]) Action_Selector_Without_Char_In_Radius(SELECTOR_PROPERTIES[0], arg_invoker_char, arg_inRadius));
	ds_list_add(mySelectorActionList, MySelectorActionClass(SELECTOR_PROPERTIES[0]));
	
	var actionProcessor = ActionProcessorClass(Action_Processor_Move());

	var selectorManager = MySelectorActionManagerClass(mySelectorActionList);
	
	_actionClass.afterInitConstructor(arg_invoker_char, selectorManager, actionProcessor);
	//var _actionClass = ActionClass(arg_invoker_char, selectorManager, actionProcessor);

	return _actionClass;
}

function Action_Predefined_Select_Character_To_Prepare_Turn() 
{
	var _actionClass = ActionClass();
	var sklEx = SKILL_EXCTRACTOR(_actionClass);
	
	var SELECTOR_PROPERTIES = [
	{
		PROPERTIES: [
			StatsClass({
				STAT_TYPE: global.STATISTICS.MOVEMENT,
				BASE_VALUE_FUNC: VALUE_FUNC(1),
				SCALING_VALUE_FUNC: VALUE_FUNC(0.5),
				STAT_SOURCE_FUNC: sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER)
			})
		],
		AREA_INCLUDE_FUNCS: [
			AreaFilterClass(
				{
				    AREA_FILTER_BUILDER_FUNC: ActionAreaFilterBuilder_AllTiles,
				    STATS_CALC_FUNC: function() { return 0 },
				    SOURCE_TILE_FUNC: sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER),
				    //CONDITION_FUNC: sklEx.EXCTRACTOR_FUNC(AC_EXTRACTOR_ENUM.INVOKER)
				}
			)
		
			//AreaFilterClass(ActionAreaFilterBuilder_AllTiles())
		],
		TILE_INCLUDE_RULE_FUNCS: [
			mapTile_filter_element_contains_character(),
			mapTile_filter_element_contains_character_and_is_NOT_prepared_for_turn(),
		]
	}]
	

	
	// SELECTOR
	var mySelectorActionList = ds_list_create();
	ds_list_add(mySelectorActionList, Action_Selector_All_Active_Chars_Without_Selected_Actions(SELECTOR_PROPERTIES[0]));
	var selectorManager = MySelectorActionManagerClass(mySelectorActionList);
	
	// ACTION PROCESSOR
	var actionProcessor = ActionProcessorClass(Action_Processor_Make_Turn_Active_For_Char());
	
	// ACTION
	//var _actionClass = ActionClass(noone, selectorManager, actionProcessor);
	
	_actionClass.afterInitConstructor(noone, selectorManager, actionProcessor);

	return _actionClass;
}



//function Action_Predefined_Select_Character_To_Prepare_Turn2() 
//{
//	var SELECTOR_PROPERTIES = [
//	{
//		STATS: {
//			TYPE: global.STATISTICS.MOVEMENT,
//			BASE: 1,
//			SCALING: 1,
//			//STAT_SOURCE: EXTRACTOR_INVOKER(arg_actionClass),
//		},
//		SHAPE_INCLUDE: [
//			{
//				//CONDITION: function() {
//				//	EXTRACTOR_INVOKER(arg_actionClass)
//				//}
//			}
//			// function(condition, shape_function)	
//		],
//		TILE_INCLUDE_RULE: {
//			// no_char_tile
//			// no tarrain_tile
//		}
//	}]
	
	
	
//	// SELECTOR
//	var mySelectorActionList = ds_list_create();
//	ds_list_add(mySelectorActionList, Action_Selector_All_Active_Chars_Without_Selected_Actions());
//	var selectorManager = MySelectorActionManagerClass(mySelectorActionList);
	
//	// ACTION PROCESSOR
//	var actionProcessor = ActionProcessorClass(Action_Processor_Make_Turn_Active_For_Char());
	
//	// ACTION
//	var _actionClass = ActionClass(noone, selectorManager, actionProcessor);

//	return _actionClass;
//}




