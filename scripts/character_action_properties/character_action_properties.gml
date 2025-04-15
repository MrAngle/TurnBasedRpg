// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
//enum ACTION_TYPE {
//	ATTACK,
//	STEP,
//	STAND
//}


function character_action_properties(_self) 
{
	PRIV_CHAR_STAT.STEP.COST.CALCULATE_CURRENT = function() {
		return PRIV_CHAR_STAT.STEP.COST.BASE;
	}
	
	get_ap_cost_func = function(action_type) {
		var closedFunction = {
			relatedObj: PRIV_CHAR_STAT.REFERENCE,
			param_action_type: action_type,
			toReturn: function() {
				return priv_impl_get_action_cost(relatedObj, param_action_type);
			}
		}
		return closedFunction.toReturn;
	}
}


function priv_impl_get_action_cost(self_obj, action_type) {
    switch (action_type) {
        case ACTION_TYPE.ATTACK:
            return 5; // koszt ataku
        case ACTION_TYPE.STEP:
            return self_obj.PRIV_CHAR_STAT.STEP.COST.CALCULATE_CURRENT(); // koszt kroku
        case ACTION_TYPE.STAND:
            return 0; // stanie nic nie kosztuje
        default:
            helper_throw_exception("UNEXPECTED ACTION TYPE: " + string(action_type));
    }
}