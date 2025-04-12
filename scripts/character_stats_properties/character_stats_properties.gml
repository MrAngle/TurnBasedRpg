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

global.STATISTICS_COMBAT_GLOBALS = {
	AP_COST: {
		MOVEMENT: {
			MIN: 2, // SET MIN/MAX AP COST
			MAX: 100,
			DEFAULT_BASE: 10
		}
	}
};

function properties_load_character_stats(_self) 
{
	PRIV_CHAR_STAT = {
		REFERENCE : _self,
		ACTION_POINTS: 0,
	    STEP: {
			COST: {
				BASE_MIN: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MIN,
				BASE_MAX: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MAX,
				BASE: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.DEFAULT_BASE,
				CALCULATE_CURRENT: function() {},
				EFFECTS: []
			}
	        //CALCULATE_VALUE_FUNC: __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(self)
	    },
	    PHYSICAL_ATTACK: {
	        BASE: 3,
	        STRENGTH_SCALING: 1
	    },
	    MAGIC_ATTACK: {
	        BASE: 1,
	        INT_SCALING: 1
	    },
		HP: {
	        BASE: 10,
			CURRENT_HP: 10,
			MAX_HP: 10
			//DRAW_HP: drawHp
	    }
	};

	receiveDamage = function(arg_attack_value) {
		PRIV_CHAR_STAT.HP.CURRENT_HP = PRIV_CHAR_STAT.HP.CURRENT_HP - arg_attack_value;
		if(PRIV_CHAR_STAT.HP.CURRENT_HP < 1) {
			instance_destroy();
		}
	}
	
	//getAttackValue = function(arg_attacked_by_char) {
	//	return PRIV_CHAR_STAT.PHYSICAL_ATTACK.BASE;
	//}
	
	getAttackValue = function(arg_attacked_by_char) {
		return REFERENCE.PRIV_CHAR_STAT.PHYSICAL_ATTACK.BASE;
	}
	
	getActionPoints = function() {
		return PRIV_CHAR_STAT.REFERENCE.PRIV_CHAR_STAT.ACTION_POINTS;
	}
	
	addActionPoints = function(argNumActionPointsToAdd) {
		PRIV_CHAR_STAT.REFERENCE.PRIV_CHAR_STAT.ACTION_POINTS = PRIV_CHAR_STAT.REFERENCE.PRIV_CHAR_STAT.ACTION_POINTS + argNumActionPointsToAdd;
	}


	if(_self.draw_container != undefined) {
		var arLenght = array_length(_self.draw_container);
		_self.draw_container[arLenght] = drawHp_returnFunc(_self)
	}
	
	character_action_properties(PRIV_CHAR_STAT.REFERENCE)
}


function drawHp_returnFunc(_self) {
	var closedFunction = {
		param_self: _self,
		toReturn: function() {
			// Pozycja paska (nad głową)
			var bar_width = 60;
			var bar_height = 10;
			var bar_x = param_self.x - bar_width/2;
			var bar_y = param_self.y - param_self.sprite_height - 10; // nad głową

			// Tło paska (szare)
			draw_set_color(c_red);
			draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

			// Pasek HP (zielony proporcjonalnie do zdrowia)
			var hp_ratio = param_self.PRIV_CHAR_STAT.HP.CURRENT_HP / param_self.PRIV_CHAR_STAT.HP.MAX_HP;
			draw_set_color(c_lime);
			draw_rectangle(bar_x, bar_y, bar_x + (bar_width * hp_ratio), bar_y + bar_height, false);
		}
	}
	return closedFunction.toReturn;
}