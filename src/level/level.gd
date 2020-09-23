extends Node


export(float) var _zoom_level: float = 0.1

onready var _map: Resource = load("res://src/map/TestMap.tscn")

var _active_map: Node2D
var _gen: int = 0


func _ready() -> void:
	_active_map = _map.instance()
	$Map.add_child(_active_map)


func new_gen() -> Vector2:
	_gen += 1
	_regenerate_map()
	return Vector2(960, 540) * (1 + (_zoom_level * _gen))


func _regenerate_map() -> void:
	_active_map.queue_free()
	_active_map = _map.instance()
	_active_map.scale = Vector2(1, 1) * (1 + (_zoom_level * _gen))
	print((1 + (_zoom_level * _gen)))
	$Map.add_child(_active_map)
