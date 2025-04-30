/// @function ActionTargetResolver(_type, [_getTargetsFunc])
/// @desc A structure responsible for resolving the actual tiles affected by an action, based on a target resolution function. If no function is passed, it is assigned based on type.
/// @returns {Struct.ActionTargetResolverInterface}
function ActionTargetResolverInterface() constructor {
    /// @returns {Array<Struct.MyMapTile>}
    getTargets = function() {
        return [];
    };
}


/// @function ActionTargetResolver_SingleTile()
/// @desc Returns a resolver that targets a single tile from context.
/// @param {Struct.MyMapTile}
/// @returns {ActionTargetResolverInterface}
function ActionTargetResolver_OriginTileAsTarget(_originTile) constructor {
    /// Readable label or type indicator (debug/info only)
    type = global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.SINGLE_TILE;

    originTile = _originTile;

    /// Returns an array of one tile from context
    getTargetTiles = function() {
        return [originTile];
    }
}