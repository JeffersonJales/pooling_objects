/// @description OBJECT POOLING
/// See the functions on -> scr_pooling_objects

// Only one instance can exists
if(instance_number(object_index) > 1){
	var _first = instance_find(object_index, 0);
	with(object_index){
		if(id != _first) 
			instance_destroy();	
	}
}