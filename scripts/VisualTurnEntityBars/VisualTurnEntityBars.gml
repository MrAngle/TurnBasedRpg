/// @param {Id.Instance.AbstTurnEntity} turnEntityObj
function visualPrintActionBar(_turnEntityObj) {
    var newvar = _turnEntityObj.__SELF();
    if (!helper_obj_is_turn_entity(_turnEntityObj)) {
        return;
    }

    var _turnEntityStruct = getTurnEntityStruct(_turnEntityObj);

    var closedOnStep = {
        turnEntityObj: _turnEntityObj,
        turnEntityStruct: _turnEntityStruct,
        bar_center_x:undefined,
        bar_center_y: undefined,
        onCreate: function(_self) {
			var bar_width = 90;
			var bar_height = 10;
			var bar_x = turnEntityObj.x - bar_width / 2;
			var bar_y = turnEntityObj.y + turnEntityObj.sprite_height * 0.5; // pod postacia

            bar_center_x = bar_x + bar_width / 2;
            bar_center_y = bar_y - 10; // 10 pikseli nad paskiem życia
        },
        onStep: function() {
            var bar_width = 90;
			var bar_height = 10;
			var bar_x = turnEntityObj.x - bar_width / 2;
			var bar_y = turnEntityObj.y + turnEntityObj.sprite_height * 0.5; // pod postacia

            bar_center_x = (bar_x + bar_width / 2) - 10;
            bar_center_y = bar_y; // 10 pikseli nad paskiem życia
        },
        onDraw: function() {
			var bar_width = 90;
			var bar_height = 10;
			var bar_x = turnEntityObj.x - bar_width / 2;
			var bar_y = turnEntityObj.y + turnEntityObj.sprite_height * 0.5; // pod postacia

            var previousAP = turnEntityStruct.getCostOfPreviousAction();
            var diffActionPoints = turnEntityStruct.getActionPoints() - global.COMBAT_GLOBALS.GAME_TURN.CURRENT_MIN_ACTION_POINTS;

            var ratio = 1 - (diffActionPoints / previousAP) ; // odwrócenie: im mniejszy diff, tym bliżej 1
            var ap_percent = clamp(ratio * 100, 0, 100);

			// Rysowanie paska życia
			draw_healthbar(
				bar_x,                      // x1
				bar_y,                      // y1
				bar_x + bar_width,          // x2
				bar_y + bar_height,         // y2
				ap_percent,                 // amount (0–100)
				c_black,                    // backcol (kolor tła)
				c_orange,                      // mincol (kolor przy 0%)
				c_yellow,                     // maxcol (kolor przy 100%)
				0,                          // direction (0 = z lewej do prawej)
				true,                       // showback (czy pokazać tło)
				true                        // showborder (czy pokazać obramowanie)
        	);

            var center_x = bar_x + bar_width / 2;
            var center_y = bar_y + bar_height / 2;
            // Przygotowanie tekstu z formatowaniem Scribble

            // Print AP value with Scribble
            // if (helper_is_not_definied(diffActionPoints)) {
                // diffActionPoints = 0;
            // }
            var ap_text = "[FNT_actionPointsBar][c_red]" + string(diffActionPoints);
            var text1 = scribble(ap_text);

            draw_scribble_with_background(text1, bar_center_x, bar_center_y, c_black)
            // text1.get
            // // text1.scale = 3;
            // draw_scribble_with_background(text1, c_black)
            // text1.draw(bar_center_x, bar_center_y);
        },
        onDestroy: function() {
        },
        shouldDestroy: function () {
            if (helper_is_not_definied(turnEntityObj) || 
                helper_is_not_definied(turnEntityStruct) || 
                turnEntityStruct.isDead()) {
                return true;
            }
            return false;
        }
    }
    createVisualGenericObjForObj(_turnEntityObj, closedOnStep);
}