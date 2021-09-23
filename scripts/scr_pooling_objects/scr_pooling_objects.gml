/// Scripts to use with obj_pooling_objects!

/// Deactive an instance. Expects this instance to be created with pooling_objects_get_instance
/// @param instance - Expects the instance id to add it to the pool
/// @retun N/A
function pooling_objects_deactive_instance(instance = self){
	var _index_on_pool = instance.__pooling_obj_index;

	with(global.obj_pool_current[? instance.object_index]){
		array_push(obj_arr_stack, _index_on_pool);
		obj_arr_stack_size++;
		have_deactive = true;
		obj_arr[_index_on_pool].status_active = false;
	}
	
	instance_deactivate_object(instance);
}

/// Get an instance from the the pool! 
/// @param obj_index - Expects the object_index to get a instance from the pool
/// @return instance_id 
function pooling_objects_get_instance(obj_index){
	var _pool = global.obj_pool_current[? obj_index];
		
	// Dont have any, create a new pool
	if(_pool == undefined){ 
		_pool = new obj_pool_struct_by_obj(obj_index);
		ds_map_add(global.obj_pool_current, obj_index, _pool);
	}
	
	return _pool.get_instance();
}
	
/// Get an instance from the pool. *Manipulate it for your own needs*
/// @param obj_index - Expects the object asset index to get an available instance from the pool
/// @param new_x 
/// @param new_y 
/// @return instance_id
function pooling_objects_get_instance_ext(obj_index, new_x = 0, new_y = 0){
	var _inst = pooling_objects_get_instance(obj_index);
	
	with(_inst){
		x = new_x;
		y = new_y;
	}
	
	return _inst;
}