/// @description OBJECT POOLING

/// See the functions on -> scr_pooling
/// All basic info here on this map
obj_pool_map = ds_map_create();			// The pool map, every object needing to be here, have a reference	
obj_pool_current = noone;	// The current pool for this room 

if(instance_number(object_index) > 1){
	var _first = instance_find(object_index, 0);
	with(object_index){
		if(id != _first) 
			instance_destroy();	
	}
}