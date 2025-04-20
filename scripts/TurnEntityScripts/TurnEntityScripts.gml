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

    /// @type {Struct.TurnEntityStruct}
	__REFERENCE = self;
    __OBJECT_REFERENCE = _objectReference
    __FACTION = FACTION_ENUM.NEUTRAL;

	ACTION_POINTS = 0;

	
    __cost = {};
	variable_struct_set(__cost, global.ENUMS.ACTION_TYPE.ATTACK.label, new ActionCostStruct(global.ENUMS.ACTION_TYPE.ATTACK))
	variable_struct_set(__cost, global.ENUMS.ACTION_TYPE.STAND.label, new ActionCostStruct(global.ENUMS.ACTION_TYPE.STAND))
	variable_struct_set(__cost, global.ENUMS.ACTION_TYPE.STEP.label, new ActionCostStruct(global.ENUMS.ACTION_TYPE.STEP))
    // __cost[global.ENUMS.ACTION_TYPE.ATTACK.label] = {}

	STEP = {
		COST: {
			BASE_MIN: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MIN,
			BASE_MAX: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.MAX,
			BASE: global.STATISTICS_COMBAT_GLOBALS.AP_COST.MOVEMENT.DEFAULT_BASE,
			EFFECTS: [],
			CALCULATE_CURRENT: function(){}
		}
	};



	PHYSICAL_ATTACK = { BASE: 3, STRENGTH_SCALING: 1 };
	HP = { BASE: 10, CURRENT_HP: 10, MAX_HP: 10 };

	get_ap_cost_func = function(action_type_enum) {
		var closed = {
			selfReference: __REFERENCE,
			param_action_type_enum: action_type_enum,
			toReturn: function() {
				return priv_impl_get_action_cost(selfReference, param_action_type_enum);
			}
		};
		return closed.toReturn;
	};

	receiveDamage = function(dmg) {
		__REFERENCE.HP.CURRENT_HP -= dmg;
		if (__REFERENCE.HP.CURRENT_HP < 1) {
            with(__REFERENCE.__OBJECT_REFERENCE) {
                instance_destroy();
            }
		}
	};

	getAttackValue = function() {
		return __REFERENCE.PHYSICAL_ATTACK.BASE;
	};

	getActionPoints = function() {
		return __REFERENCE.ACTION_POINTS;
	};

    getFaction = function() {
		return __REFERENCE.__FACTION;
	};

	addActionPoints = function(val) {
		__REFERENCE.ACTION_POINTS += val;
	};
}


function priv_impl_get_action_cost(self_obj, action_type_enum) {
    switch (action_type_enum) {
        case ACTION_TYPE_ENUM.ATTACK:
            return 5; // koszt ataku
        case ACTION_TYPE_ENUM.STEP:
            return self_obj.PRIV_CHAR_STAT.STEP.COST.CALCULATE_CURRENT(); // koszt kroku
        case ACTION_TYPE_ENUM.STAND:
            return 0; // stanie nic nie kosztuje
        default:
            helper_throw_exception("UNEXPECTED ACTION TYPE: " + string(action_type_enum));
    }
}