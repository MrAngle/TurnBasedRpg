global.STATISTICS_COMBAT_GLOBALS = {
	AP_COST: {
		MOVEMENT: {
			MIN: 2, // SET MIN/MAX AP COST
			MAX: 100,
			DEFAULT_BASE: 10
		}
	}
};

/// @constructor
/// @param {object} _self - Reference to the owning instance.
/// @returns {TurnEntityStruct}
function TurnEntityStruct(_objectReference) constructor {

	__ID = helperGenerateUniqueId();

	__STATS = new TurnEntityStatsStruct();

    /// @type {Struct.TurnEntityStruct}
	// __REFERENCE = self;
    __OBJECT_REFERENCE = _objectReference
    // __FACTION = FACTION_ENUM.NEUTRAL;

	// __EFFECTS = {}
	
    // __ACTION_COST_STAT = {};
	// variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.ATTACK.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.ATTACK))
	// variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.STAND.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.STAND))
	// variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.STEP.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.STEP))

	// ACTION_POINTS = 0;

	// PHYSICAL_ATTACK = { BASE: 3, STRENGTH_SCALING: 1 };
	// HP = { BASE: 10, CURRENT_HP: 10, MAX_HP: 10 };
	

	/// SETTERS
	/// @param {Enum.FACTION_ENUM}
	setFaction = function(_fraction) {
		__STATS.setFaction(_fraction);
	}

	/// @return {Enum.FACTION_ENUM}
	getFaction = function() {
		return __STATS.__FACTION
	}

		
	/// @param {Struct.ActionContextStruct} _actionContextStruct
	consumeActionPoints = function(_actionContextStruct) {

		var actionsToConsume = __STATS.applyActionPoints(_actionContextStruct);
		// self.ACTION_POINTS += actionsToConsume;
	}

	receiveDamage = function(dmg) {
		__STATS.HP.CURRENT_HP -= dmg;
		if (__STATS.HP.CURRENT_HP < 1) {
            with(self.__OBJECT_REFERENCE) {
                instance_destroy();
            }
		}
	};

	getAttackValue = function() {
		return __STATS.PHYSICAL_ATTACK.BASE;
	};

	getActionPoints = function() {
		return __STATS.ACTION_POINTS;
	};

    getFaction = function() {
		return __STATS.__FACTION;
	};

	addActionPoints = function(val) {
		__STATS.ACTION_POINTS += val;
	};
}


// function priv_impl_get_action_cost(self_obj, action_type_enum) {
//     switch (action_type_enum) {
//         case ACTION_TYPE_ENUM.ATTACK:
//             return 5; // koszt ataku
//         case ACTION_TYPE_ENUM.STEP:
//             return self_obj.PRIV_CHAR_STAT.STEP.COST.CALCULATE_CURRENT(); // koszt kroku
//         case ACTION_TYPE_ENUM.STAND:
//             return 0; // stanie nic nie kosztuje
//         default:
//             helper_throw_exception("UNEXPECTED ACTION TYPE: " + string(action_type_enum));
//     }
// }