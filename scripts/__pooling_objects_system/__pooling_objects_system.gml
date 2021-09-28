/// Made by @jalesjefferson
/// Github link -> https://github.com/JeffersonJales/pooling_objects

#macro POOLING_OBJECTS_MAP_KEYS_ARR "__keys_arr"  
#macro POOLING_OBJECTS_MAP_KEYS_RELOAD "__reload_on_room_start"
#macro POOLING_OBJECT_RELOAD_FUNC_VAR_NAME "__pooling_objects_reload_callback"

global.obj_pool_map = ds_map_create();	// The pool map, every object needing to be here, have a reference	
global.obj_pool_current = undefined;		// The current pool for this room 

/// @param obj_ind - Expects a object index
function __pooling_objects_struct_by_object(obj_ind) constructor {

	obj_index = obj_ind;						// The object index reference
	have_deactive = false;					// Case dont have any deactive, instantiate
																	
	obj_arr = [];										// Saves instances of __pooling_objects_instance_info struct
	obj_arr_size = 0;								// The amount of instances
	
	obj_stack = ds_stack_create();	// The instances index on obj_arr that are deactive
	obj_stack_size = 0;							// The stack size -> Easy way to see if have a active or deactive instance
}

function __pooling_objects_perform_create_event(){
	event_perform(ev_create, 0);	
}

function __pooling_objects_room_start(){
	/// Pick room pool
	var _pool = global.obj_pool_map[? room];

	if(_pool == undefined){
		_pool = ds_map_create();
		ds_map_add(_pool, POOLING_OBJECTS_MAP_KEYS_ARR, []);
		ds_map_add(_pool, POOLING_OBJECTS_MAP_KEYS_RELOAD, false);
		ds_map_add_map(global.obj_pool_map, room, _pool);
	}
	else if(_pool[? POOLING_OBJECTS_MAP_KEYS_RELOAD]) {
		_pool[? POOLING_OBJECTS_MAP_KEYS_RELOAD] = false;
		var _keys_arr = _pool[? POOLING_OBJECTS_MAP_KEYS_ARR];
	
		var _per_obj_struct;
		for(var _i = 0; _i < array_length(_keys_arr); _i++){
			_per_obj_struct = _pool[? _keys_arr[_i++]];
		
			for(var _f = 0; _f < _per_obj_struct.obj_arr_size; _f++){
				if(!_per_obj_struct.obj_arr[_f].__pooling_objects_inst_active)
					instance_deactivate_object(_per_obj_struct.obj_arr[_f]);
			}
		}
	}

	global.obj_pool_current = _pool;

}

function __pooling_objects_room_end(){
	/// Case the room is persistent, 
	/// we want to preserve the instances that are deactive
	/// So, reactive all the instances, before room transition
	var _keys = global.obj_pool_current[? POOLING_OBJECTS_MAP_KEYS_ARR];

	if(room_persistent){ 
		global.obj_pool_current[? POOLING_OBJECTS_MAP_KEYS_RELOAD] = true;
	
		var _i = 0, _f = 0;
		repeat(array_length(_keys)){
			with(global.obj_pool_current[? _keys[_i++]]){
				_f = 0;
				repeat(obj_arr_size){
					instance_activate_object(obj_arr[_f++]);
				}
			}
		}
	}
	
	/// If we are moving to another room, clear the pool data structure
	else {
	
		// Clear array and struct
		var _i = 0, _struct;
		repeat(array_length(_keys)){
			_struct = global.obj_pool_current[? _keys[_i++]];
			_struct.obj_arr = 0;
			ds_stack_destroy(_struct.obj_stack);
			delete _struct;			
		}	
	
		// Destroy ds_map for this room
		ds_map_delete(global.obj_pool_map, room); 
		ds_map_destroy(global.obj_pool_current);
		global.obj_pool_current = undefined;
	}
}
