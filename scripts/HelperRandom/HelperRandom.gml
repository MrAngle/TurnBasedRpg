global.uniqueIdCounter = 0;

/// @function generateUniqueId
/// @description Generates a globally unique numeric ID using a counter.
/// @returns {number} A unique numeric identifier.
function helperGenerateUniqueId() {
    global.uniqueIdCounter += 1;
    return global.uniqueIdCounter;
}