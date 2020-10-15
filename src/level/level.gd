extends Node


var _map_resource: Resource
var _active_map: Node2D


func get_entities_container() -> Node:
	return $Entities


func set_map(map_resource: Resource) -> void:
	_map_resource = map_resource
	_active_map = _map_resource.instance()
	$Map.add_child(_active_map)


func reset_map(new_scale: float) -> void:
	_active_map.queue_free()
	_active_map = _map_resource.instance()
	_active_map.scale = Vector2(1, 1) * new_scale
	$Map.add_child(_active_map)
