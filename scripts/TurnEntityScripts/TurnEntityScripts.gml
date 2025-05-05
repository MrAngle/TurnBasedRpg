global.STATISTICS_COMBAT_GLOBALS = {
	AP_COST: {
		MOVEMENT: {
			MIN: 2,
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

	/// @type {Id.Instance.AbstTurnEntity}
    __OBJECT_REFERENCE = _objectReference;

	/// @type {Array<Struct.CombatEventEffect>}
	__EVENT_EFFECTS = [];

	/// SETTERS
	/// @param {Enum.FACTION_ENUM}
	setFaction = function(_fraction) {
		__STATS.setFaction(_fraction);
	}

	/// @return {Enum.FACTION_ENUM}
	getFaction = function() {
		return __STATS.__FACTION
	}

	getId = function() {
		return __ID;
	}

	getTileLocationStruct = function() {
		return getTileLocationFromObjOrStruct(__OBJECT_REFERENCE);
	}

	getCurrentHp = function() {
		return __STATS.getCurrentHp()
	}

	/// @returns {Array<Struct.CombatEventEffect>}
	getAllEventEffects = function() {
		return __EVENT_EFFECTS;
	}
	////////////////////////////////////////////////// LOGIC

	/// @param {Id.Instance.AbstTurnEntity} _turnEntityObj
	/// @returns {Bool}
	isSameTurnEntityObj = function(_turnEntityObj) {
		if(helper_struct_is_undefined_or_empty(_turnEntityObj)) {
			return false
		}
		var te = getTurnEntityStruct(_turnEntityObj);

		if(helper_struct_is_undefined_or_empty(te)) {
			return false;
		}

		return __ID == te.getId();
	}

	/// @param {Struct.TurnEntityStruct} _turnEntityStruct
	/// @returns {Bool}
	isSameTurnEntityStruct = function(_turnEntityStruct) {
		if(helper_struct_is_undefined_or_empty(_turnEntityStruct)) {
			return false
		}

		return __ID == _turnEntityStruct.getId();
	}
		
	/// @param {Struct.ActionContextStruct} _actionContextStruct
	/// @returns {real} -1 if no action points were consumed, otherwise the number of action points consumed.
	consumeActionPoints = function(_actionContextStruct) {
		var actionsToConsume = __STATS.applyActionPoints(_actionContextStruct);
		return actionsToConsume;
	}

	/// @param {Real} ap_to_subtract - Wartość AP, którą odejmujemy z każdej jednostki.
	prepareActionPointsForNextTurn = function(ap_to_subtract) {
		__STATS.prepareActionPointsForNextTurn(ap_to_subtract);
	}

	applyHpChange = function(dmg) {
        TextReceiveDamage(__OBJECT_REFERENCE, dmg);
		visualsShakeObject(__OBJECT_REFERENCE);
		__STATS.HP.CURRENT_HP += dmg;
		if (isDead()) {
            with(self.__OBJECT_REFERENCE) {
                instance_destroy();
            }
		}
	};

	getAttackDamage = function() {
		return -1 * getAttackValue();
	}

	getAttackValue = function() {
		return __STATS.PHYSICAL_ATTACK.BASE;
	};

	getActionPoints = function() {
		return __STATS.getActionPoints();
	};

	getCostOfPreviousAction = function() {
		return __STATS.getCostOfPreviousAction();
	};

	isDead = function() {
		return __STATS.HP.CURRENT_HP < 1
	}

    getFaction = function() {
		return __STATS.__FACTION;
	};
}
