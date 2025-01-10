function QueueAction(_object_name, _first_action) {
    return {
        object_name: _object_name,  // Nazwa obiektu przypisanego do kolejki
        action: _first_action,     // Funkcja do wykonania
        next_action: undefined,    // Odnośnik do kolejnej akcji w kolejce
        actions: {},               // Struktura przechowująca akcje indeksowane nazwami obiektów

        // Dodawanie funkcji do kolejki
        add_action: function(_key, _new_action) {
            if (!is_undefined(actions[_key])) {
                return; // Jeśli klucz istnieje, nie dodawaj ponownie
            }
            
            var new_action = QueueAction(_key, _new_action);
            actions[_key] = new_action;

            // Dodaj nową akcję jako pierwszą, aby super rodzic był wykonany jako ostatni
            if (self.next_action == undefined) {
                self.next_action = new_action;
            } else {
                new_action.next_action = self.next_action;
                self.next_action = new_action;
            }
        },

        // Wykonanie wszystkich akcji w kolejce
        execute: function() {
            if (self.action != undefined) {
                self.action(_arg); // Wykonaj bieżącą akcję
            }
            if (self.next_action != undefined) {
                self.next_action.execute(); // Wykonaj kolejną akcję
            }
        },

        // Usunięcie akcji z kolejki
        remove_action: function(_key) {
            if (!is_undefined(actions[_key])) {
                var to_remove = actions[_key];
                actions[_key] = undefined;

                // Odłącz z łańcucha
                var current = self;
                while (current.next_action != undefined) {
                    if (current.next_action == to_remove) {
                        current.next_action = to_remove.next_action;
                        break;
                    }
                    current = current.next_action;
                }
            }
        }
    };
}