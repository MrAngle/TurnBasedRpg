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

function properties_load_character_stats() 
{
	priv_character_statistics = {
	    MOVEMENT: {
	        BASE: 2,
	        CALCULATE_VALUE_FUNC: __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(self)
	    },
	    PHYSICAL_ATTACK: {
	        BASE: 1,
	        STRENGTH_SCALING: 1
	    },
	    MAGIC_ATTACK: {
	        BASE: 1,
	        INT_SCALING: 1
	    },
		HP: {
	        BASE: 10,
	    }
	};
	
	__priv_character_stats_base_action_points = 20;
	__priv_character_stats_current_action_points = __priv_character_stats_base_action_points;
	
	getCalculatedStatsValue = function(arg_stats_global_STATISTICS) {
		var local_stats = variable_struct_get(priv_character_statistics, arg_stats_global_STATISTICS);
		return variable_struct_get(local_stats, global.STATISTICS.CALCULATE_VALUE_FUNC)();
	}
}

function __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(arg_character) {
	closedFunction = {
		__character: arg_character,
		toReturn: function() {
			return variable_struct_get(__character.priv_character_statistics, global.STATISTICS.MOVEMENT).BASE;
		}
	}
	return closedFunction.toReturn;

}