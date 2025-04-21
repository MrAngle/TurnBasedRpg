/// @param {Id.Instance.AbstTurnEntity} turnEntityObj
function visualPrintActionBar(_turnEntityObj) {

    if (!helper_obj_is_turn_entity(_turnEntityObj)) {
        return;
    }

    var _turnEntityStruct = getTurnEntityStruct(_turnEntityObj);

    var closedOnStep = {
        turnEntityObj: _turnEntityObj,
        turnEntityStruct: _turnEntityStruct,
        onStep: function() {
            timer -= 1;
            target.x = original_x + random_range(-intensity, intensity);
            target.y = original_y + random_range(-intensity, intensity);
        },
        onDestroy: function() {
            if(helper_is_definied(target)) {
                target.x = original_x;
                target.y = original_y;
            } else {
                LOG_CRITICAL_MESSAGE("SD")
            }
        },
        shouldDestroy: function () {
            if (helper_is_not_definied(turnEntityObj) || helper_is_not_definied(turnEntityStruct)) {
                return true;
            }
            return false;
        }
    }
    createVisualGenericObjForObj(objToShake, closedOnStep);
}