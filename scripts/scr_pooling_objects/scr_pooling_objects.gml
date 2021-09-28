/// Scripts to use with obj_pooling_objects!

/// Deactive an instance. Expects this instance to be created with pooling_objects_get_instance
/// @param instance - Expects the instance id or an object index (With object index, it will deactive all instances of this object
/// @retun N/A
function pooling_objects_deactive_instance(instance = self){
	with(instance){
		ds_stack_push(__pooling_objects_struct_ref.obj_stack, __pooling_objects_arr_index);
		__pooling_objects_inst_active = false;
		__pooling_objects_struct_ref.obj_stack_size++;
		__pooling_objects_struct_ref.have_deactive = true; 
		instance_deactivate_object(id);
	}
}

/// Get an instance from the the pool! 
/// @param obj_index - Expects the object_index to get a instance from the pool
/// @return instance_id 
function pooling_objects_get_instance(obj_index){
	var _pool = global.obj_pool_current[? obj_index];
		
	// Dont have any, create a new pool
	if(_pool == undefined){ 
		_pool = new __pooling_objects_struct_by_object(obj_index);
		ds_map_add(global.obj_pool_current, obj_index, _pool);
	}
	
	var _instance;
	
	#region Get Instance ------- 
	if(_pool.have_deactive){ /// GET FROM POOL
		_pool.have_deactive = --_pool.obj_stack_size > 0;
		_instance = _pool.obj_arr[ds_stack_pop(_pool.obj_stack)];
		
		instance_activate_object(_instance);
		_instance.__pooling_objects_inst_active = true;
		_instance.__pooling_objects_reload_callback();
	}
	else { /// A NEW INSTANCE! ADD IT TO THE POOL
		_instance = instance_create_depth(0, 0, 0, obj_index);
		_instance.__pooling_objects_arr_index = _pool.obj_arr_size; 
		_instance.__pooling_objects_inst_active = true;
		_instance.__pooling_objects_struct_ref = _pool;
		
		if(!variable_instance_exists(_instance, POOLING_OBJECT_RELOAD_FUNC_VAR_NAME))
			_instance.__pooling_objects_reload_callback = __pooling_objects_perform_create_event;
		
		array_push(_pool.obj_arr, _instance); 
		++_pool.obj_arr_size;
	}
	#endregion Get Instance ----
	
	return _instance;	
}

/// Set up a callback function when getting an instance from the pool - Default is create_event
/// @param callback - Expects a function. Will be called on the instance scope.
/// @param instance - The instance 
function pooling_object_set_reload_callback(callback){
	if(is_method(callback)){
		with(other)
			__pooling_objects_reload_callback = method(id, callback);
	}
}

/// EXAMPLE --------------------------------------------------------------
/// Get an instance from the pool. 
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