function CombatEventService() constructor {

    /// @param {Struct.ActionContextStruct} _actionContextStruct
	emitOnTriggerEvents = function(_actionContextStruct) {
		var allUnits = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getAllTurnEntityStructs();
		var subtypesToTrigger = _actionContextStruct.getEventsTypeEnumsToTrigger();

		for (var i = 0; i < array_length(allUnits); i++) {
			var unit = allUnits[i];
			var effects = unit.getAllEventEffects();

			for (var j = 0; j < array_length(effects); j++) {
				var effect = effects[j];


				effect.tryTrigger(_actionContextStruct);
			}
		}
	};

    /// Sprawdza, czy dwie tablice ENUM_STRUCT mają wspólny element (porównując po .id)
    __hasCommonEnumSubtype = function (a, b) {
        for (var i = 0; i < array_length(a); i++) {
            var enumA = a[i];
            for (var j = 0; j < array_length(b); j++) {
                if (a[i].id == b[j].id) return true;
            }
        }
        return false;
    }
}
