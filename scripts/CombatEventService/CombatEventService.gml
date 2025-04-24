function CombatEventService() constructor {
    /// @param {Struct.ENUM_STRUCT}
    // emitOnTriggerEvents = function(eventSubtypeId, context) {
    //     var allUnits = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getAllTurnEntityStructs();

    //     for (var i = 0; i < array_length(allUnits); i++) {
    //         var unit = allUnits[i];

    //         var effects = unit.getAllEventEffects();

    //         for (var j = 0; j < array_length(effects); j++) {
    //             var effect = effects[j];

    //             if (!array_contains(effect.getEventSubtypesEnums(), eventSubtypeId)) continue;
    //             if (!effect.shouldTrigger(context)) continue;

    //             effect.onTrigger(context);
    //         }
    //     }
    // };

    	/// @param {Struct.ActionContextStruct} _actionContextStruct
	emitOnTriggerEvents = function(_actionContextStruct) {
		var allUnits = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getAllTurnEntityStructs();
		var subtypesToTrigger = _actionContextStruct.getEventsTypeEnumsToTrigger();

		for (var i = 0; i < array_length(allUnits); i++) {
			var unit = allUnits[i];
			var effects = unit.getAllEventEffects();

			for (var j = 0; j < array_length(effects); j++) {
				var effect = effects[j];
				// var effectSubtypes = effect.getEventSubtypesEnums(); // Array of ENUM_STRUCT

				// // Czy efekt reaguje na któryś z subtypów
				// if (!__hasCommonEnumSubtype(effectSubtypes, subtypesToTrigger)) continue;

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
