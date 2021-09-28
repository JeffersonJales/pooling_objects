/// @description 

// Inherit the parent event
event_inherited();

list = ds_list_create();
map = ds_map_create();

layer_get_id("Instances");
layer_get_id("Background");
layer_get_id("Null");
image_angle = irandom(359)