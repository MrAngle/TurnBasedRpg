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
	
	CALCULATE_MODIFIERS_FUNCTION: "CALCULATE_MODIFIERS"
};

function properties_load_character_stats() 
{
	priv_character_statistics = {
	    MOVEMENT: {
	        BASE: 0,
	        CALCULATE_MODIFIERS_FUNCTION: __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(self)
	    },
	    PHYSICAL_ATTACK: {
	        BASE_DAMAGE: 1,
	        STRENGTH_SCALING: 1
	    },
	    MAGIC_ATTACK: {
	        BASE_DAMAGE: 1,
	        INT_SCALING: 1
	    }
	};
	
	
	__priv_character_stats_base_action_points = 20;
	__priv_character_stats_current_action_points = __priv_character_stats_base_action_points;
}

function __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(arg_character) {
	var calculate_modifiers = function(closed_arg_base_radius, closed_arg_invoker_char) {
		closedFunction = {
			__character: arg_character,
			toReturn: function() {
				return __character.priv_character_statistics[global.STATISTICS.MOVEMENT].BASE;
			}
		}
		return calculate_modifiers.toReturn;
	}

}