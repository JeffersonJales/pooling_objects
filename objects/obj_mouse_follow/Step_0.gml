/// @description 
x = mouse_x;
y = mouse_y;

if(mouse_check_button_pressed(mb_left)){
	var _bullet = obj_pool_get_from_pool(obj_bullet);
	_bullet.x = x;
	_bullet.y = y;
}

if(mouse_check_button_pressed(mb_middle)){
	var _bullet_2 = obj_pool_get_from_pool(obj_bullet2);
	_bullet_2.x = x;
	_bullet_2.y = y;
}


if(keyboard_check_pressed(vk_space)){
	room_persistent = !room_persistent;	
}

if(mouse_check_button_pressed(mb_right)){
	switch(room){
		case Room_1: room_goto(Room_2); break;
		case Room_2: room_goto(Room_3); break;
		case Room_3: room_goto(Room_1); break;
	}
}
