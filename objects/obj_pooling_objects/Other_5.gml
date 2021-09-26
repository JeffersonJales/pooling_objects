/// @description Handle pool in room end
/// For more info abour the data from global.obj_pool_map -> __pooling_objects_struct_by_object


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
		_struct = global.obj_pool_current[? _keys[_i++]];
		_struct.obj_arr = 0;
		delete _struct;			
	}	
	
	// Destroy ds_map for this room
	ds_map_delete(global.obj_pool_map, room); 
	ds_map_destroy(global.obj_pool_current);
	global.obj_pool_current = undefined;
}