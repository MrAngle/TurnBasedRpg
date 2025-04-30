// /// @function ActionTargetResolver(_type, [_getTargetsFunc])
// /// @desc A structure responsible for resolving the actual tiles affected by an action, based on a target resolution function. If no function is passed, it is assigned based on type.
// /// @param {ActionTargetResolverType} _type - The identifier type used for debugging or informational purposes.
// /// @param {function} [_getActionTargetsFunc] - Optional. A function that takes an ActionContext and returns an array of affected tiles.
// /// @returns {struct}
// function ActionTargetResolver(_type, _getActionTargetsFunc) constructor {

//     type = _type;

//     getTargets = (_getActionTargetsFunc != undefined)
//         ? _getActionTargetsFunc
//         : __actionTargetResolver_GetDefaultFunctionForType(_type);
// }

/// @function ActionTargetResolver_GetDefaultFunctionForType
/// @desc Returns a target resolver function based on the ActionTargetResolverType enum.
/// @param {Struct.ENUM_STRUCT} _type - The resolver type enum.
/// @returns {function}
function __actionTargetResolver_GetDefaultFunctionForType(_type) {
    
    if (_type == global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.SINGLE_TILE) {
        return function(_context) {
            return [_context.targetTile];
        };
    }

    if (_type == global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.AREA_EXPLOSION) {
        return function(_context) {
            return TargetResolver_Helper_GetTilesInRadius(_context.targetTile, 1);
        };
    }

    if (_type == global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.CONE) {
        return function(_context) {
            return TargetResolver_Helper_GetTilesInCone(_context.executorTile, _context.targetTile, 3);
        };
    }

    if (_type == global.ENUMS.ACTION_TARGET_RESOLVER_TYPE.STATIC_TILE) {
        return function(_context) {
            // Placeholder - actual tile should probably come from closure at creation time
            return [_context.targetTile];
        };
    }

    LOG_CRITICAL_MESSAGE("[ActionTargetResolver] No default function for type: " + string(_type.label) + ". Returning empty array.");
    // Default fallback
    return function(_context) {
        return [];
    };
}

/// @function __ACTION_TARGET_RESOLVER_TYPE_ENUM
/// @description Enum structure defining target resolution strategies for actions.
/// @returns {Struct.__ACTION_TARGET_RESOLVER_TYPE_ENUM}
function __ACTION_TARGET_RESOLVER_TYPE_ENUM() constructor {
    /// Target is a single tile (e.g., basic attack)
    SINGLE_TILE      = new ENUM_STRUCT(50, "SINGLE_TILE");

    /// Targets all tiles in a radius around a target (e.g., explosion)
    AREA_EXPLOSION   = new ENUM_STRUCT(51, "AREA_EXPLOSION");

    /// Targets all tiles in a cone shape from origin to target (e.g., flame breath)
    CONE             = new ENUM_STRUCT(52, "CONE");

    /// Targets a specific static tile, regardless of context
    STATIC_TILE      = new ENUM_STRUCT(53, "STATIC_TILE");

    /// Targets nothing (fallback / no-op)
    NONE             = new ENUM_STRUCT(54, "NONE");
}