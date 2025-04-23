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

	/// @type {Id.Instance.AbstTurnEntity}
    __OBJECT_REFERENCE = _objectReference

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
	////////////////////////////////////////////////// LOGIC

	/// @param {Id.Instance.AbstTurnEntity}
	/// @returns {Bool}
	isSameTurnEntity = function(_turnEntityObj) {
		if(helper_object_not_exists(_turnEntityObj)) {
			return false
		}
		var te = getTurnEntityStruct(_turnEntityObj);

		if(helper_is_not_definied(te)) {
			return false;
		}

		return __ID == te.getId();
	}
		
	/// @param {Struct.ActionContextStruct} _actionContextStruct
	consumeActionPoints = function(_actionContextStruct) {
		var actionsToConsume = __STATS.applyActionPoints(_actionContextStruct);
	}

	receiveDamage = function(dmg) {
		__STATS.HP.CURRENT_HP -= dmg;
        TextReceiveDamage(__OBJECT_REFERENCE, dmg);
		visualsShakeObject(__OBJECT_REFERENCE);
		if (isDead()) {
            with(self.__OBJECT_REFERENCE) {
                instance_destroy();
            }
		}
	};

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
