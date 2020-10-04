extends Node


onready var _level: Resource = load("res://src/level/Level.tscn")
onready var _empty_map: Resource = load("res://src/map/EmptyMap.tscn")
onready var _default_map: Resource = load("res://src/map/TestMap.tscn")

var _actif_level: Node
var _zoom_mult: float = 1.1
var _gen: int = 0


func _ready() -> void:
	ReplayClock.reset_timer()
	_actif_level = _level.instance()
	_actif_level.set_map(_default_map)
	$Levels.add_child(_actif_level)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_new_gen()


func _new_gen() -> void:
	_gen += 1
	var zoom_level: float = pow(_zoom_mult, _gen)
	for l in $Levels.get_children():
		l.reset_map(zoom_level)
	for p in get_tree().get_nodes_in_group("Player"):
		p.refresh()
	for l in get_tree().get_nodes_in_group("Logger"):
		$LoggerConverter.convert_to_player(l, _zoom_mult)
	_actif_level = _level.instance()
	_actif_level.set_map(_empty_map)
	$Levels.add_child(_actif_level)
	ReplayClock.reset_timer()
	CameraManager.get_camera().position = Vector2(960, 540) * zoom_level
#	var logs_buffer = []
#	for e in get_tree().get_nodes_in_group("Logger"):
#		logs_buffer.append(e.get_log_data())
#	_regenerate_map()
#	for e in logs_buffer:
#		var clone
#		if e.has("clone") and e["clone"]:
#			clone = e["clone"]
#		else:
#			clone = _clone
#		var entity_player = _entity_player.instance()
#		entity_player.setup(e["log"], clone)
##		clone.setup(e)
##		_active_map.add_child(clone)
#		_active_map.add_child(entity_player)
