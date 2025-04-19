// // W wersji v2.3.0 zmieniono zasoby skryptu. Więcej informacji można znaleźć pod adresem
// // https://help.yoyogames.com/hc/en-us/articles/360005277377
//enum ActionType {
//    MOVEMENT = "MOVEMENT",
//    PHYSICAL_ATTACK = "PHYSICAL_ATTACK",
//    MAGIC_ATTACK = "MAGIC_ATTACK"
//}

global.STATISTICS = {
    MOVEMENT: "MOVEMENT",
    PHYSICAL_ATTACK: "PHYSICAL_ATTACK",
    MAGIC_ATTACK: "MAGIC_ATTACK",
    HP: "HP",
	
	CALCULATE_VALUE_FUNC: "CALCULATE_VALUE_FUNC"
};

//function properties_load_character_stats() 
//{
//	PRIV_CHAR_STAT = {
//	    MOVEMENT: {
//	        BASE: 2,
//	        CALCULATE_VALUE_FUNC: __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(self)
//	    },
//	    PHYSICAL_ATTACK: {
//	        BASE: 1,
//	        STRENGTH_SCALING: 1
//	    },
//	    MAGIC_ATTACK: {
//	        BASE: 1,
//	        INT_SCALING: 1
//	    },
//		HP: {
//	        BASE: 10,
//	    }
//	};
	
//	__priv_character_stats_base_action_points = 20;
//	__priv_character_stats_current_action_points = __priv_character_stats_base_action_points;
	
//	getCalculatedStatsValue = function(arg_stats_global_STATISTICS) {
//		var local_stats = variable_struct_get(PRIV_CHAR_STAT, arg_stats_global_STATISTICS);
//		return variable_struct_get(local_stats, global.STATISTICS.CALCULATE_VALUE_FUNC)();
//	}
//}

//function __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(arg_character) {
//	closedFunction = {
//		__character: arg_character,
//		toReturn: function() {
//			return variable_struct_get(__character.PRIV_CHAR_STAT, global.STATISTICS.MOVEMENT).BASE;
//		}
//	}
//	return closedFunction.toReturn;

//}





// function properties_load_character_stats(_self) 
// {
	// PRIV_CHAR_STAT = {
	// 	REFERENCE : _self,
	// 	ACTION_POINTS: 0,
	//     STEP: {
	// 		COST: {
	// 			BASE_MIN: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MIN,
	// 			BASE_MAX: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MAX,
	// 			BASE: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.DEFAULT_BASE,
	// 			CALCULATE_CURRENT: function() {},
	// 			EFFECTS: []
	// 		}
	//         //CALCULATE_VALUE_FUNC: __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(self)
	//     },
	//     PHYSICAL_ATTACK: {
	//         BASE: 3,
	//         STRENGTH_SCALING: 1
	//     },
	//     MAGIC_ATTACK: {
	//         BASE: 1,
	//         INT_SCALING: 1
	//     },
	// 	HP: {
	//         BASE: 10,
	// 		CURRENT_HP: 10,
	// 		MAX_HP: 10
	// 		//DRAW_HP: drawHp
	//     }
	// };
	
	// __STATS = privGetStats(__SELF());

	// receiveDamage = function(arg_attack_value) {
	// 	__STATS().HP.CURRENT_HP = __STATS().HP.CURRENT_HP - arg_attack_value;
	// 	if(PRIV_CHAR_STAT.HP.CURRENT_HP < 1) {
	// 		instance_destroy();
	// 	}
	// }
	
	// getAttackValue = function(arg_attacked_by_char) {
	// 	return __STATS().PHYSICAL_ATTACK.BASE;
	// }
	
	// getActionPoints = function() {
	// 	return __STATS().ACTION_POINTS;
	// }
	
	// addActionPoints = function(argNumActionPointsToAdd) {
	// 	__STATS().ACTION_POINTS = __STATS().ACTION_POINTS + argNumActionPointsToAdd;
	// }


	// if(_self.draw_container != undefined) {
	// 	var arLenght = array_length(_self.draw_container);
	// 	_self.draw_container[arLenght] = drawHp_returnFunc(_self)
	// }
	
	// character_action_properties(__STATS().REFERENCE)
// }

// function privGetStats(_self) {
// 	var closedFunction = {
// 		param_self: _self,
// 		toReturn: function() {
// 			return param_self.PRIV_CHAR_STAT;
// 		}
// 	}
// 	return closedFunction.toReturn;
// }

