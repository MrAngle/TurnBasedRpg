///

/// @param {Struct.TurnEntityStruct} _turnEntityStruct
function INIT_ZOMBIE_STATS(_turnEntityStruct) {
    var _turnEntityStatsStruct = _turnEntityStruct.__STATS

    /// @type {Struct.__ActionCostStructAbst}
    var actionCost = _turnEntityStatsStruct.__ACTION_COST_STAT;
    actionCost.ATTACK.__base = 15;
    actionCost.STEP.__base = 10;
    actionCost.STAND.__base = 20;

    _turnEntityStatsStruct.HP.BASE = 10000;
    _turnEntityStatsStruct.HP.CURRENT_HP = 10000;

    _turnEntityStatsStruct.PHYSICAL_ATTACK.BASE = 5;


}
