
function helper_room_move_to_room(_room_next) {
    global.previous_room = room;
	room_goto(_room_next);
}


function helper_room_move_to_previous_room() {
	var currentRoom = room;
	room_goto(global.previous_room);
    global.previous_room = currentRoom;
}

function helper_room_move_to_previous_room_function() {
	var currentRoom = room;
	room_goto(global.previous_room);
    global.previous_room = currentRoom;

}