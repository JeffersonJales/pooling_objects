/// @description FOLLOW MOUSE + INPUT
x = mouse_x;
y = mouse_y;

if(mouse_check_button_pressed(mb_left)){
	var _bullet = pooling_objects_get_instance(obj_example_bullet);
	_bullet.x = x;
	_bullet.y = y;
}

if(mouse_check_button_pressed(mb_right)){
	pooling_objects_get_instance_ext(obj_example_bullet_2, x, y);
}


if(keyboard_check_pressed(vk_space)){
	room_persistent = !room_persistent;	
}

if(mouse_check_button_pressed(mb_middle)){
	switch(room){
		case Room_1: room_goto(Room_2); break;
		case Room_2: room_goto(Room_1); break;
	}
}
