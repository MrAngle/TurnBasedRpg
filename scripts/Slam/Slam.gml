/// 

function COMBAT_EVENT_EFFECT_SLAM() {
    var rearAssaultEffect = new CombatEventEffect(
        [global.EVENT_SUBTYPES_ENUM.ON_ATTACK],
    
        // shouldTrigger: tylko jeśli to appliesTo wykonuje atak
        /// @param {Struct.ActionContextStruct} _actionContextStruct
        function(_actionContextStruct) {
            return _actionContextStruct.getActionInvokerStruct().isSameTurnEntity(appliesTo)
        },
    
        // onTrigger: wykonaj dodatkowy atak z tej samej pozycji
        function(context) {
            // nowa akcja – atak na ten sam cel co oryginalny atak
            var newAction = new ActionStruct(
                global.ActionTypes.ATTACK,        // typ akcji
                appliesTo,                         // ten sam atakujący
                context.targetTile,                // ten sam cel
                context.from_intent                // ta sama intencja
            );
    
            var newContext = new ActionContextStruct(newAction);
            var resolved = new __ActionResolvedStruct(newContext);
            resolved.__INIT();
            resolved.execute();
        },
    
        self, // appliesTo
        {
            name: "REAR_ASSAULT",
            icon: spr_rear_assault,
            description: "Performs a follow-up attack after each offensive strike.",
            tags: ["passive", "combo"]
        }
    );
}
