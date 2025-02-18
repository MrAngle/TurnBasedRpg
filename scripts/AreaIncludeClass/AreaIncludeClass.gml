// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377

				

function AreaIncludeClass(arg_areaFilterFunc, arg_ConditionFunc = noone) 
{
	return {
		__areaFilterFunc: arg_areaFilterFunc, // return array of tiles
		__conditionFunc: arg_ConditionFunc,   // return true or false
		
		isConditionTrue: function() {
			if(helper_function_is_undefined_or_noone(__conditionFunc)) {
				return true;
			}
			
			return __conditionFunc();
		},
		
		getTilesToInclude: function() {
			if(isConditionTrue()) {
				return __areaFilterFunc();
			}
			return [];
		}
	}
}

//PREDEFINE conditionFunc

//function CONDITION_ALWAYS_TRUE