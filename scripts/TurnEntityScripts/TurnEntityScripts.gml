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

    /// @type {Struct.TurnEntityStruct}
	// __REFERENCE = self;
    __OBJECT_REFERENCE = _objectReference
    __FACTION = FACTION_ENUM.NEUTRAL;

	__EFFECTS = {}
	
    __ACTION_COST_STAT = {};
	variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.ATTACK.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.ATTACK))
	variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.STAND.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.STAND))
	variable_struct_set(__ACTION_COST_STAT, global.ENUMS.ACTION_TYPE.STEP.label, new ActionCostStruct(self, global.ENUMS.ACTION_TYPE.STEP))

	
	/// @param {Struct.ActionContextStruct} _actionContextStruct
	consumeActionPoints = function(_actionContextStruct) {
		/// @type {Struct.ActionCostStruct}
		var actionPointsToConsume = variable_struct_get(__ACTION_COST_STAT, _actionContextStruct.getAction().getType().label);

		self.ACTION_POINTS += actionPointsToConsume.calculateActionCost(_actionContextStruct);
	}

	ACTION_POINTS = 0;

    // __cost[global.ENUMS.ACTION_TYPE.ATTACK.label] = {}

	// STEP = {
	// 	COST: {
	// 		BASE_MIN: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MIN,
	// 		BASE_MAX: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MAX,
	// 		BASE: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.DEFAULT_BASE,
	// 		EFFECTS: [],
	// 		CALCULATE_CURRENT: function(){}
	// 	}
	// };



	PHYSICAL_ATTACK = { BASE: 3, STRENGTH_SCALING: 1 };
	HP = { BASE: 10, CURRENT_HP: 10, MAX_HP: 10 };


	receiveDamage = function(dmg) {
		self.HP.CURRENT_HP -= dmg;
		if (self.HP.CURRENT_HP < 1) {
            with(self.__OBJECT_REFERENCE) {
                instance_destroy();
            }
		}
	};

	getAttackValue = function() {
		return self.PHYSICAL_ATTACK.BASE;
	};

	getActionPoints = function() {
		return self.ACTION_POINTS;
	};

    getFaction = function() {
		return self.__FACTION;
	};

	addActionPoints = function(val) {
		self.ACTION_POINTS += val;
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