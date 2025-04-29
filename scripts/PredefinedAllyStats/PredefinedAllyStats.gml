/// 
/// @param {Struct.TurnEntityStruct} _turnEntityStruct
function INIT_NECRO_STATS(_turnEntityStruct) {
    var _turnEntityStatsStruct = _turnEntityStruct.__STATS

    /// @type {Struct.__ActionCostStructAbst}
    var actionCost = _turnEntityStatsStruct.__ACTION_COST_STAT;
    actionCost.ATTACK.__base = 5;
    actionCost.STEP.__base = 3;
    actionCost.STAND.__base = 10;

    _turnEntityStatsStruct.HP.BASE = 100;
    _turnEntityStatsStruct.HP.CURRENT_HP = 100;

    _turnEntityStatsStruct.PHYSICAL_ATTACK.BASE = 101;

    array_push(_turnEntityStruct.__EVENT_EFFECTS, COMBAT_EVENT_EFFECT_SLAM(_turnEntityStruct.__OBJECT_REFERENCE));
    array_push(_turnEntityStruct.__EVENT_EFFECTS, COMBAT_EVENT_EFFECT_EXPLODE(_turnEntityStruct.__OBJECT_REFERENCE));
}
