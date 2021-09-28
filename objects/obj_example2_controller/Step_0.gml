/// @description 
if(keyboard_check_pressed(vk_f11))
	show_debug_overlay(true);

if(keyboard_check_pressed(vk_f12))
	show_debug_overlay(false);

if(room == Room_1){
	repeat(amount){
		instance_create_depth(x, y, 0, obj_example_bullet_3);
		instance_create_depth(x, y, 0, obj_example_bullet_4);
	}
}
else{ 
	repeat(amount){
		pooling_objects_get_instance_ext(obj_example_bullet, x, y);
		pooling_objects_get_instance_ext(obj_example_bullet_2, x, y);
	}
}
		