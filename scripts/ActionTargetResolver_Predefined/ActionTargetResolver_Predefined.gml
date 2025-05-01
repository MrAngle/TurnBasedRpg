/// @function __ACTION_TARGET_RESOLVER_TYPE_ENUM
/// @description Enum structure defining target resolution strategies for actions.
/// @returns {Struct.__ACTION_TARGET_RESOLVER_TYPE_ENUM}
function __ACTION_TARGET_RESOLVER_TYPE_ENUM() constructor {
    /// Target is a single tile (e.g., basic attack)
    ORIGIN_TARGET_TILE  = new ENUM_STRUCT(50, "ORIGIN_TARGET_TILE");
    CLOSEST_ENEMY  = new ENUM_STRUCT(51, "CLOSEST_ENEMY");

    /// Targets all tiles in a cone shape from origin to target (e.g., flame breath)
    CONE                = new ENUM_STRUCT(52, "CONE");

    /// Targets a specific static tile, regardless of context
    STATIC_TILES         = new ENUM_STRUCT(53, "STATIC_TILES");

    /// Targets nothing (fallback / no-op)
    NONE                = new ENUM_STRUCT(54, "NONE");

    
    /// Targets all tiles in a radius around a target (e.g., explosion)
    AREA_EXPLOSION      = new ENUM_STRUCT(100, "AREA_EXPLOSION");
    SURROUNDING_TILES   = new ENUM_STRUCT(101, "SURROUNDING_TILES");
    TARGET_BEHIND       = new ENUM_STRUCT(102, "TARGET_BEHIND");
    TARGET_BEHIND_IF_TE_EXISTS       = new ENUM_STRUCT(103, "TARGET_BEHIND_IF_TE_EXISTS");
}

/// @function ActionTargetResolver(_type, [_getTargetsFunc])
/// @desc A structure responsible for resolving the actual tiles affected by an action, based on a target resolution function. If no function is passed, it is assigned based on type.
/// @returns {Struct.ActionTargetResolverInterface}
function ActionTargetResolverInterface() constructor {

    /// @param {Struct.__ActionStruct} _actionStruct
    /// @returns {Array<Struct.MyMapTile>}
    getTargetTiles = function(_actionStruct) {
        LOG_CRITICAL_MESSAGE("[ActionTargetResolverInterface] getTargetTiles not implemented. Returning empty array.");
    };
}

/// @function ActionTargetResolver_SingleTile()
/// @desc Returns a resolver that targets a single tile from context.
/// @param {Struct.MyMapTile}
/// @returns {ActionTargetResolverInterface}
function ActionTargetResolver_OriginTileAsTarget() constructor {
    /// Readable label or type indicator (debug/info only)
    type = global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.ORIGIN_TARGET_TILE;

    /// Returns an array of one tile from context
    /// @param {Struct.__ActionStruct} _actionStruct
    getTargetTiles = function(_actionStruct) {
        var arrayTargetTiles = _actionStruct.getArrayOriginTargetTiles();
        if(helper_array_is_empty(arrayTargetTiles)) {
            return [];
        }

        return _actionStruct.getArrayOriginTargetTiles();
    }
}

/// @function ActionTargetResolver_SingleTile()
/// @desc Returns a resolver that targets a single tile from context.
/// @param {Struct.MyMapTile}
/// @returns {ActionTargetResolverInterface}
function ActionTargetResolver_SURROUNDING_TILES() constructor {
    /// Readable label or type indicator (debug/info only)
    type = global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.SURROUNDING_TILES;

    /// Returns an array of one tile from context
    /// @param {Struct.__ActionStruct} _actionStruct
    getTargetTiles = function(_actionStruct) {
        var arrayTargetTiles = _actionStruct.getArrayOriginTargetTiles();
        if(helper_array_is_empty(arrayTargetTiles)) {
            return [];
        }

        var resultTargetTiles = [];

        for (var i = 0; i < array_length(arrayTargetTiles); i++) {
            var tile = arrayTargetTiles[i];
            var surroundingTiles = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getSurroundingArrayTiles(tile);
    
            if (!helper_array_is_empty(surroundingTiles)) {
                helper_array_concat(resultTargetTiles, surroundingTiles);
            }
        }

        return resultTargetTiles;
    }
}

/// @function ActionTargetResolver_SingleTile()
/// @desc Returns a resolver that targets a single tile from context.
/// @param {Struct.MyMapTile}
/// @returns {ActionTargetResolverInterface}
function ActionTargetResolver_None() constructor {
    /// Readable label or type indicator (debug/info only)
    type = global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.NONE;

    /// Returns an array of one tile from context
    /// @param {Struct.__ActionStruct} _actionStruct
    getTargetTiles = function(_actionStruct) {
        return [];
    }
}

/// @function ActionTargetResolver_SingleTile()
/// @desc Returns a resolver that targets a single tile from context.
/// @param {Array<Struct.MyMapTile>} _arrayMapTiles
/// @returns {ActionTargetResolverInterface}
function ActionTargetResolver_STATIC_TILES(_arrayMapTiles) constructor {
    /// Readable label or type indicator (debug/info only)
    type = global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.STATIC_TILES;
    __arrayMapTiles = _arrayMapTiles;

    /// Returns an array of one tile from context
    /// @param {Struct.__ActionStruct} _actionStruct
    getTargetTiles = function(_actionStruct) {
        return [__arrayMapTiles];
    }
}

/// @function ActionTargetResolver_SingleTile()
/// @desc Returns a resolver that targets a single tile from context.
/// @param {Struct.MyMapTile}
/// @returns {ActionTargetResolverInterface}
function ActionTargetResolver_TargetBehind() constructor {
    /// Readable label or type indicator (debug/info only)
    type = global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.TARGET_BEHIND;

    /// Returns an array of one tile from context
    /// @param {Struct.__ActionStruct} _actionStruct
    getTargetTiles = function(_actionStruct) {
        var arrayTargetTiles = _actionStruct.getArrayOriginTargetTiles();
        if(helper_array_is_empty(arrayTargetTiles)) {
            return [];
        }

        var resultTargetTiles = [];

        for (var i = 0; i < array_length(arrayTargetTiles); i++) {
            var tile = arrayTargetTiles[i];
    
            var invokerLocation = _actionStruct.getInvokerTuEnStruct().getTileLocationStruct();
            var targetLocation = tile.getTileLocationStruct();
            var targetTileBehind = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.getTileBehind(invokerLocation, targetLocation);

            if (targetTileBehind != undefined) {
                array_push(resultTargetTiles, targetTileBehind);
            }
        }

        return resultTargetTiles;
    }
}

/// @function ActionTargetResolver_SingleTile()
/// @desc Returns a resolver that targets a single tile from context.
/// @param {Struct.MyMapTile}
/// @returns {ActionTargetResolverInterface}
function ActionTargetResolver_ClosedEnemy() constructor {
    type = global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.CLOSEST_ENEMY;

    /// @param {Struct.__ActionStruct} _actionStruct
    getTargetTiles = function(_actionStruct) {
        var originTiles = _actionStruct.getArrayOriginTargetTiles();
        if (helper_array_is_empty(originTiles)) return [];

        var invokerStruct = _actionStruct.getInvokerTuEnStruct();
        var invokerTeam = invokerStruct.getFaction();
        var mapHolder = global.COMBAT_GLOBALS.MAP.MAP_HOLDER;

        var radius = 3; // lub inna wartość
        var foundTile = undefined;

        for (var i = 0; i < array_length(originTiles); i++) {
            var origin = originTiles[i];
            var tilesInDistance = mapTile_filter_within_distance(invokerStruct.getTileLocationStruct(), 5);
			var surrounding = global.COMBAT_GLOBALS.MAP.MAP_HOLDER.get_tiles([tilesInDistance]);
            // var surrounding = mapHolder.getTilesInRadius(origin, radius);

            for (var j = 0; j < array_length(surrounding); j++) {
                var tile = surrounding[j];
                var entity = tile.getTurnEntityStruct();

                if (entity != undefined && entity.getFaction() != invokerTeam) {
                    foundTile = tile;
                    break;
                }
            }

            if (foundTile != undefined) break;
        }

        return foundTile != undefined ? [foundTile] : [];
    };
}
