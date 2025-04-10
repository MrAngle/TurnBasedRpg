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
//	priv_character_statistics = {
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
//		var local_stats = variable_struct_get(priv_character_statistics, arg_stats_global_STATISTICS);
//		return variable_struct_get(local_stats, global.STATISTICS.CALCULATE_VALUE_FUNC)();
//	}
//}

//function __CALCULATE_MODIFIERS_MOVEMENT_FUNCTION(arg_character) {
//	closedFunction = {
//		__character: arg_character,
//		toReturn: function() {
//			return variable_struct_get(__character.priv_character_statistics, global.STATISTICS.MOVEMENT).BASE;
//		}
//	}
//	return closedFunction.toReturn;

//}



function properties_load_character_stats(_self) 
{
	priv_character_statistics = {
		REFERENCE : _self,
	    MOVEMENT: {
	        BASE: 2,
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
		priv_character_statistics.HP.CURRENT_HP = priv_character_statistics.HP.CURRENT_HP - arg_attack_value;
		if(priv_character_statistics.HP.CURRENT_HP < 1) {
			instance_destroy();
		}
	}
	
	getAttackValue = function(arg_attacked_by_char) {
		return priv_character_statistics.PHYSICAL_ATTACK.BASE;
	}
	
	getAttackValue = function(arg_attacked_by_char) {
		return priv_character_statistics.PHYSICAL_ATTACK.BASE;
	}


	if(_self.draw_container != undefined) {
		var arLenght = array_length(_self.draw_container);
		_self.draw_container[arLenght] = drawHp_returnFunc(_self)
	}
}

//function drawHp(_self) {
//		// Pozycja paska (nad głową)
//		var bar_width = 40;
//		var bar_height = 6;
//		var bar_x = _self.x - bar_width/2;
//		var bar_y = _self.y - _self.sprite_height - 10; // nad głową

//		// Tło paska (szare)
//		draw_set_color(c_gray);
//		draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

//		// Pasek HP (zielony proporcjonalnie do zdrowia)
//		var hp_ratio = _self.priv_character_statistics.HP.CURRENT_HP / _self.priv_character_statistics.HP.MAX_HP;
//		draw_set_color(c_lime);
//		draw_rectangle(bar_x, bar_y, bar_x + (bar_width * hp_ratio), bar_y + bar_height, false);
//}

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
			var hp_ratio = param_self.priv_character_statistics.HP.CURRENT_HP / param_self.priv_character_statistics.HP.MAX_HP;
			draw_set_color(c_lime);
			draw_rectangle(bar_x, bar_y, bar_x + (bar_width * hp_ratio), bar_y + bar_height, false);
		}
	}
	return closedFunction.toReturn;
}