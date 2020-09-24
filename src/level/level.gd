extends Node


export(float) var _zoom_level: float = 0.1

onready var _map: Resource = load("res://src/map/TestMap.tscn")
onready var _clone: Resource = load("res://src/clone/Clone.tscn")

var _active_map: Node2D
var _gen: int = 0


func _ready() -> void:
	_active_map = _map.instance()
	$Map.add_child(_active_map)


func new_gen() -> Vector2:
	_gen += 1
	var logs_buffer = []
	for e in get_tree().get_nodes_in_group("Logged"):
		logs_buffer.append(e.get_logs())
	_regenerate_map()
	for e in logs_buffer:
		var clone = _clone.instance()
		clone.setup(e)
		_active_map.add_child(clone)
		print("eeeee")
	return Vector2(960, 540) * (1 + (_zoom_level * _gen))


func _regenerate_map() -> void:
	_active_map.queue_free()
	_active_map = _map.instance()
	_active_map.scale = Vector2(1, 1) * (1 + (_zoom_level * _gen))
	$Map.add_child(_active_map)
