/// @description 

// Inherit the parent event
event_inherited();

pooling_object_set_reload_callback(function(){
	image_angle = irandom(359);
	speed = irandom_range(1, 3);
});