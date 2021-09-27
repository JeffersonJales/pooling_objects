/// Made by @jalesjefferson
/// Github link -> https://github.com/JeffersonJales/pooling_objects

#macro POOLING_OBJECTS_MAP_KEYS_ARR "__keys_arr"  
#macro POOLING_OBJECTS_MAP_KEYS_RELOAD "__reload_on_room_start"
#macro POOLING_OBJECT_RELOAD_FUNC_VAR_NAME "__pooling_objects_reload_callback"

global.obj_pool_map = ds_map_create();	// The pool map, every object needing to be here, have a reference	
global.obj_pool_current = undefined;		// The current pool for this room 

/// @param obj_ind - Expects a object index
function __pooling_objects_struct_by_object(obj_ind) constructor {

	obj_index = obj_ind;		// The object index reference
	have_deactive = false;	// Case dont have any deactive, instantiate
	
	obj_arr = [];						// Saves instances of __pooling_objects_instance_info struct
	obj_arr_size = 0;				// The amount of instances
	obj_arr_stack = [];			// Pick the most recent deactive instance
	obj_arr_stack_size = 0; // The size of the stack
	
	/// Adding a instance to this pool
	/// @return N/A
	static add_instance =	function(instance, active = true){
		var _struct = new __pooling_objects_instance_info(instance, active);
		array_push(obj_arr, _struct); 
		++obj_arr_size;
	}
	
	/// Getting a instance from this pool
	/// Case don't have an available, instatiate
	/// @return instance_id
	static get_instance = function(){
		var _instance;
		
		// Case have a deactive instance, pick the last deactive
		if(have_deactive){ 
			have_deactive = --obj_arr_stack_size > 0;	// Check if have a deactive instance
			
			with(obj_arr[array_pop(obj_arr_stack)]){  // An __pooling_objects_instance_info reference
				instance_activate_object(instance);
				status_active = true;
				_instance = instance;
				_instance.__pooling_objects_reload_callback(); // The callback function set with pooling_object_set_reload_callback 
			}
		}
		
		// Case doesn't have an availabe instance, create a new one
		else {
			_instance = instance_create_depth(0, 0, 0, obj_index);
			_instance.__pooling_objects_arr_index = obj_arr_size; 
			
			with(_instance){
				__pooling_objects_struct_ref = other;
				if(!variable_instance_exists(id, POOLING_OBJECT_RELOAD_FUNC_VAR_NAME))
					__pooling_objects_reload_callback = __pooling_objects_perform_create_event;
			}
			
			add_instance(_instance);
		}
		
		return _instance;
	}

}

/// @param inst - Expects the instance id reference
/// @param active - If the instance is active or deactive. Used in rooms with persistance
function __pooling_objects_instance_info(inst, active = true) constructor{
	instance = inst;				
	status_active = active;	
}

function __pooling_objects_perform_create_event(){
	event_perform(ev_create, 0);	
}