/// @param {Id.Instance.AbstTurnEntity} _objReference
function properties_load_turn_entity(_objTurnEntity) {
	__TURN_ENTITY_ATTRIBUTES = new TurnEntityStruct(_objTurnEntity);

	/// @type {Struct.TurnEntityStruct}
	getTurnEntity = __getTurnEntity(_objTurnEntity);

	if(_objTurnEntity.draw_container != undefined) {
		var arLenght = array_length(_objTurnEntity.draw_container);
		_objTurnEntity.draw_container[arLenght] = drawHp_returnFunc(_objTurnEntity)
	}

	visualPrintActionBar(_objTurnEntity);
}

/// @returns {Struct.TurnEntityStruct}
function __getTurnEntity(_objTurnEntity) {
	var closedFunction = {
		relatedObj: _objTurnEntity,
		toReturn: function() {
			return relatedObj.__TURN_ENTITY_ATTRIBUTES;
		}
	}
	return closedFunction.toReturn;
}

/// @param {Id.Instance.AbstTurnEntity} _objReference
/// @returns {Struct.TurnEntityStruct}
function getTurnEntityStruct(_objReference) {
	/// @type {} // any object - add validation in feature
	var ref = _objReference
	return ref.getTurnEntity();
}

function drawHp_returnFunc(_self) {
	var closedFunction = {
		// param_self: _self,
		// toReturn: function() {
		// 	/// @type {Struct.TurnEntityStruct}
		// 	var turnEntityStruct = param_self.getTurnEntity()

		// 	// Pozycja paska (nad głową)
		// 	var bar_width = 60;
		// 	var bar_height = 10;
		// 	var bar_x = param_self.x - bar_width/2;
		// 	var bar_y = param_self.y - param_self.sprite_height - 10; // nad głową

		// 	// Tło paska (szare)
		// 	draw_set_color(c_red);
		// 	draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

		// 	// Pasek HP (zielony proporcjonalnie do zdrowia)
		// 	var hp_ratio = turnEntityStruct.__STATS.HP.CURRENT_HP / turnEntityStruct.__STATS.HP.MAX_HP;
		// 	draw_set_color(c_lime);
		// 	draw_rectangle(bar_x, bar_y, bar_x + (bar_width * hp_ratio), bar_y + bar_height, false);
		// }
		param_self: _self,
    	toReturn: function() {
			/// @type {Struct.TurnEntityStruct}
			var turnEntityStruct = param_self.getTurnEntity();

			// Pozycja paska (nad głową)
			var bar_width = 60;
			var bar_height = 10;
			var bar_x = param_self.x - bar_width / 2;
			var bar_y = param_self.y - param_self.sprite_height - 10; // nad głową

			// Obliczenie procentowego wypełnienia paska
			var hp_ratio = turnEntityStruct.__STATS.HP.CURRENT_HP / turnEntityStruct.__STATS.HP.BASE;
			var hp_percent = clamp(hp_ratio * 100, 0, 100); // Upewnij się, że wartość mieści się w zakresie 0–100

			// Rysowanie paska życia
			draw_healthbar(
				bar_x,                      // x1
				bar_y,                      // y1
				bar_x + bar_width,          // x2
				bar_y + bar_height,         // y2
				hp_percent,                 // amount (0–100)
				c_black,                    // backcol (kolor tła)
				c_red,                      // mincol (kolor przy 0%)
				c_lime,                     // maxcol (kolor przy 100%)
				0,                          // direction (0 = z lewej do prawej)
				true,                       // showback (czy pokazać tło)
				true                        // showborder (czy pokazać obramowanie)
        	);
		}
	}
	return closedFunction.toReturn;
}