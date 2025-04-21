/// @param {Id.Instance.AbstTurnEntity} turnEntityObj
function visualPrintActionBar(_turnEntityObj) {

    if (!helper_obj_is_turn_entity(_turnEntityObj)) {
        return;
    }

    var _turnEntityStruct = getTurnEntityStruct(_turnEntityObj);

    var closedOnStep = {
        turnEntityObj: _turnEntityObj,
        turnEntityStruct: _turnEntityStruct,
        onStep: function() {},
        onDraw: function() {
			var bar_width = 60;
			var bar_height = 10;
			var bar_x = turnEntityObj.x - bar_width / 2;
			var bar_y = turnEntityObj.y + turnEntityObj.sprite_height * 0.5; // pod postacia

            var currentAP = turnEntityStruct.getActionPoints();
            var previousAP = turnEntityStruct.getActionPreviousPoints();

            var gainedAp = currentAP - previousAP;

            var minAP = global.COMBAT_GLOBALS.ACTION.CURRENT_MIN_ACTION_POINTS;

            var diffActionPoints = turnEntityStruct.getActionPoints() - global.COMBAT_GLOBALS.ACTION.CURRENT_MIN_ACTION_POINTS;
            var ratio =  (diffActionPoints / gainedAp) ; // odwrócenie: im mniejszy diff, tym bliżej 1
			var hp_percent = clamp(ratio * 100, 0, 100); // Upewnij się, że wartość mieści się w zakresie 0–100


            // var currentAP = turnEntityStruct.getActionPoints();
            // var previousAP = turnEntityStruct.getActionPreviousPoints();
            // var minAP = global.COMBAT_GLOBALS.ACTION.CURRENT_MIN_ACTION_POINTS;

            // // Ile AP zostało "naładowane" od poprzedniej akcji
            // var gainedAP = currentAP - previousAP;

            // // Ile AP muszę uzbierać od poprzedniej akcji, żeby osiągnąć minimum do działania
            // var requiredToAct = minAP - previousAP;

            // // Oblicz proporcję
            // var ratio = gainedAP / requiredToAct;



            var hp_percent = clamp(ratio * 100, 0, 100);


			// Rysowanie paska życia
			draw_healthbar(
				bar_x,                      // x1
				bar_y,                      // y1
				bar_x + bar_width,          // x2
				bar_y + bar_height,         // y2
				hp_percent,                 // amount (0–100)
				c_black,                    // backcol (kolor tła)
				c_yellow,                      // mincol (kolor przy 0%)
				c_yellow,                     // maxcol (kolor przy 100%)
				0,                          // direction (0 = z lewej do prawej)
				true,                       // showback (czy pokazać tło)
				true                        // showborder (czy pokazać obramowanie)
        	);
        },
        onDestroy: function() {
        },
        shouldDestroy: function () {
            if (helper_is_not_definied(turnEntityObj) || helper_is_not_definied(turnEntityStruct)) {
                return true;
            }
            return false;
        }
    }
    createVisualGenericObjForObj(_turnEntityObj, closedOnStep);
}