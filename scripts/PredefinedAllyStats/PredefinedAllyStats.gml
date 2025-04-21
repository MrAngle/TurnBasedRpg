/// 
/// @param {Struct.TurnEntityStruct} _turnEntityStruct
function INIT_NECRO_STATS(_turnEntityStruct) {
    var _turnEntityStatsStruct = _turnEntityStruct.__STATS

    /// @type {Struct.__ActionCostStructAbst}
    var actionCost = _turnEntityStatsStruct.__ACTION_COST_STAT;
    actionCost.ATTACK.__base = 5;
    actionCost.STEP.__base = 3;
    actionCost.STAND.__base = 10;

    _turnEntityStatsStruct.HP.BASE = 50;
    _turnEntityStatsStruct.HP.CURRENT_HP = 50;

    _turnEntityStatsStruct.PHYSICAL_ATTACK.BASE = 5;
}
