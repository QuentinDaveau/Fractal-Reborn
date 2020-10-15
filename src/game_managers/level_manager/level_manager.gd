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
	$SpawnManager.update_area()
	$ArenaBound.update_bounds()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_new_gen()


func _new_gen() -> void:
	_gen += 1
	var zoom_level: float = pow(_zoom_mult, _gen)
	$ItemsSpawner.stop_spawn()
	for l in $Levels.get_children():
		l.reset_map(zoom_level)
	for p in get_tree().get_nodes_in_group("Player"):
		p.refresh()
	for l in get_tree().get_nodes_in_group("Logger"):
		$LoggerConverter.convert_to_player(l, _zoom_mult)
	_actif_level = _level.instance()
	_actif_level.set_map(_empty_map)
	$Levels.add_child(_actif_level)
	CameraManager.get_camera().position = Vector2(960, 540) * zoom_level
	$ArenaBound.update_bounds()
	$SpawnManager.update_area()
	$PlayersSpawner.spawn_players(_actif_level, $SpawnManager)
	yield($PlayersSpawner, "players_spawned")
	$ItemsSpawner.start_spawn()
