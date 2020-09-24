extends Node


onready var _level: Resource = load("res://src/level/Level.tscn")

var _level_instance: Node


func _ready() -> void:
	_level_instance = _level.instance()
	add_child(_level_instance)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var map_center_position = _level_instance.new_gen()
		CameraManager.get_camera().position = map_center_position
