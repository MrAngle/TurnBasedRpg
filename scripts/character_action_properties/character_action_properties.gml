// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
//enum ACTION_TYPE {
//	ATTACK,
//	STEP,
//	STAND
//}


// function character_action_properties(_self) 
// {
// 	PRIV_CHAR_STAT.STEP.COST.CALCULATE_CURRENT = function() {
// 		return PRIV_CHAR_STAT.STEP.COST.BASE;
// 	}
	
// 	get_ap_cost_func = function(action_type_enum) {
// 		var closedFunction = {
// 			relatedObj: PRIV_CHAR_STAT.REFERENCE,
// 			param_action_type_enum: action_type_enum,
// 			toReturn: function() {
// 				return priv_impl_get_action_cost(relatedObj, param_action_type_enum);
// 			}
// 		}
// 		return closedFunction.toReturn;
// 	}
// }


