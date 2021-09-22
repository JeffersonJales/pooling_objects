/// Scripts to use with obj_pooling!

/// Deactive a instance. Expects this instance on the pool! 
/// @param instance - Expects the instance id to add it to the pool
/// @retun N/A
function obj_pool_deactive_instance(instance = self){
	with(obj_pooling){
		var _struct = obj_pool_current[? instance.object_index];
		var _index_on_pool = instance.obj_pool_struct.index_on_pool;
		with(_struct){
			array_push(obj_arr_stack, _index_on_pool);
			obj_arr_stack_size++;
			have_deactive = true;
			obj_arr[_index_on_pool].status_active = false;
		}
	}
	
	instance_deactivate_object(instance);
}

/// Get a instance from the the pool! 
/// @param obj_index - Expects the object_index to get a instance from the pool
/// @return instance_id 
function obj_pool_get_from_pool(obj_index){
	var _pool;
	with(obj_pooling){
		_pool = obj_pool_current[? obj_index];
		
		// Dont have any, create the ds_map
		if(_pool == undefined){ 
			_pool = new obj_pool_struct_by_obj(obj_index);
			ds_map_add(obj_pool_current, obj_index, _pool);
		}
	}
	
	return _pool.get_instance();
}