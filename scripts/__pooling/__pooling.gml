/// Made by @jalesjefferson
#macro POOL_MAP_KEYS_ARR "__keys_arr"
#macro POOL_MAP_KEYS_RELOAD "__reload_on_room_start"

/// INIT OBJ_POOL
instance_create_depth(0, 0, 0, obj_pooling)

/// @param obj_ind - Expects a object index
function obj_pool_struct_by_obj(obj_ind) constructor {

	obj_index = obj_ind;		// The object index reference
	have_deactive = false;	// Case dont have any deactive, instantiate
	
	obj_arr = [];						// Saves instances of obj_pool_instance_info 
	obj_arr_size = 0;				// The amount of instances
	obj_arr_stack = [];			// Pick the most recent deactive instance
	obj_arr_stack_size = 0; // The size of the stack
	
	/// Adding a instance to this pool
	/// @return N/A
	add_instance =	function(instance, active = true){
		var _struct = new obj_pool_instance_info(instance, active);
		array_push(obj_arr, _struct); 
		++obj_arr_size;
	}
	
	/// Getting a instance from this pool
	/// Case don't have an available, instatiate
	/// @return instance_id
	get_instance = function(){
		var _instance;
		
		// Case have a deactive instance, pick the last deactive
		if(have_deactive){ 
			var _struct = obj_arr[array_pop(obj_arr_stack)]; // Pick the last one
			have_deactive = --obj_arr_stack_size > 0; // Check if have a deactive instance

			with(_struct){  // An obj_pool_instance_info reference
				instance_activate_object(instance);
				status_active = true;
				_instance = instance;
			}
		}
		
		// Case doesn't have an availabe instance, create a new one
		// Also, pass some information in a struct to the instance about the pool
		else {
			_instance = instance_create_depth(0, 0, 0, obj_index);
			_instance.obj_pool_struct = new obj_pool_configure_instance(obj_arr_size);
			add_instance(_instance);
		}
		
		return _instance;
	}
}

/// @param inst - Expects the instance id reference
/// @param active - If the instance is active or deactive
function obj_pool_instance_info(inst, active = true) constructor{
	instance = inst;				// The instance reference id
	status_active = active;	// If the instance is active or not
}

/// When a instance is add to the pool, we will pass this struct 
/// with some infomation to the instance
///	for faster information collection
/// It will be saved as obj_pool_struct on the instance
/// @param index_on_pool_arr - The position on the 
function obj_pool_configure_instance(index_on_pool_arr) constructor{
	using_pooling = true;							
	index_on_pool = index_on_pool_arr;
}
