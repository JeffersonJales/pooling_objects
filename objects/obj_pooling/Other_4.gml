/// @description Deactive Instances

/// Pick room pool
var _pool = obj_pool_map[? room];

if(_pool == undefined){
	_pool = ds_map_create();
	ds_map_add(_pool, POOL_MAP_KEYS_ARR, []);
	ds_map_add(_pool, POOL_MAP_KEYS_RELOAD, false);
	ds_map_add_map(obj_pool_map, room, _pool);
}
else if(_pool[? POOL_MAP_KEYS_RELOAD]) {
	_pool[? POOL_MAP_KEYS_RELOAD] = false;
	var _keys_arr = _pool[? POOL_MAP_KEYS_ARR];
	
	var _per_obj_struct;
	for(var _i = 0; _i < array_length(_keys_arr); _i++){
		_per_obj_struct = _pool[? _keys_arr[_i++]];
		
		for(var _f = 0; _f < _per_obj_struct.obj_arr_size; _f++){
			if(!_per_obj_struct.obj_arr[_f].status_active)
				instance_deactivate_object(_per_obj_struct.obj_arr[_f].instance);
		}
	}
}

obj_pool_current = _pool;
