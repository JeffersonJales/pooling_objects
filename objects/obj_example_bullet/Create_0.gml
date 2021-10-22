/// @description Randomize bullet
speed = 5;
direction = irandom(359);
image_blend = choose(	c_aqua, c_dkgray, c_orange, c_olive, c_lime);

pooling_objects_set_reload_callback(function(){
	image_blend = choose(	c_aqua, c_dkgray, c_orange, c_olive, c_lime);
})