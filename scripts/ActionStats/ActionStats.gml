/// @returns {Struct.ActionStats}
function ActionStats() constructor {
    // Costs and resources
    action_cost = 0;             // Total cost of the action (e.g., action points)
    resource_changes = {};       // Changes in resources (e.g., {mana: -10, stamina: -5})

    // Damage statistics
    total_damage = 0;            // Total damage dealt
    damage_to_enemies = 0;       // Damage dealt to enemies
    damage_to_allies = 0;        // Damage dealt to allies
    damage_breakdown = [];       // Detailed damage info (e.g., [{target: enemy1, amount: 50, type: "fire"}])

    // Hit statistics
    hits = 0;                    // Number of successful hits
    misses = 0;                  // Number of missed attacks
    critical_hits = 0;           // Number of critical hits

    // Status effects
    effects_applied = [];        // List of applied effects (e.g., ["burn", "stun"])
    effects_resisted = [];       // List of resisted effects

    // Environment interactions
    tiles_affected = [];         // List of affected tiles
    objects_destroyed = [];      // List of destroyed objects during the action

    // Additional information
    execution_time = 0;          // Execution time of the action (e.g., in milliseconds)
    success = true;              // Indicates if the action was successful
}
