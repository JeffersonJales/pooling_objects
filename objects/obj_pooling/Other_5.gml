/// @description Handle pool in room end
/// For more info abour the data from obj_pool_map -> obj_pool_struct_by_obj


/// Case the room is persistent, 
/// we want to preserve the instances that are deactive
/// So, reactive all the instances, before room transition
var _keys = obj_pool_current[? POOL_MAP_KEYS_ARR];

if(room_persistent){ 
	obj_pool_current[? POOL_MAP_KEYS_RELOAD] = true;
	
	var _i = 0, _f = 0;
	repeat(array_length(_keys)){
		with(obj_pool_current[? _keys[_i++]]){
			_f = 0;
			repeat(obj_arr_size){
				instance_activate_object(obj_arr[_f++].inst);
			}
		}
	}
}
	
/// If we are moving to another room, clear the pool data structure
else {
	
	// Clear array and struct
	var _i = 0, _struct;
	repeat(array_length(_keys)){
		_struct = obj_pool_current[? _keys[_i++]];
		_struct.obj_arr = 0;
		delete _struct;			
	}	
	
	// Destroy ds_map for this room
	ds_map_delete(obj_pool_map, room); 
	ds_map_destroy(obj_pool_current);
	obj_pool_current = undefined;
}