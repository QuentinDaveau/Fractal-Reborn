extends Node
# Node dedicated to replay the actions of a defined entity from a given log
# (a log being an Animation)

const REPLAY_SLOW_MULT: float = 1.5

var _log: Animation
var _entity: Resource

var _zoom_mult: float = 1.0
var _clone_gen: int = 1


# On ready, plays the log
func _ready() -> void:
	$AnimationPlayer.play("log", -1, 1 / pow(_zoom_mult * REPLAY_SLOW_MULT, _clone_gen))


# Sets the log and its associated entity
func setup(new_log: Animation, entity: Resource, zoom_mult: float) -> void:
	_log = new_log
	_entity = entity
	_zoom_mult = zoom_mult
	$AnimationPlayer.add_animation("log", _log)
	var e = _entity.instance()
	if e is Replayable:
		e.enable_replay()
	$Entity.set_scale(Vector2(1, 1) * pow(_zoom_mult, _clone_gen))
	$Entity.add_child(e)


# Returns the Entity being replayed
func get_entity() -> Node:
	return $Entity.get_child(0)


# Resets the entity
func refresh() -> void:
	_clone_gen += 1
	$AnimationPlayer.stop()
	if $Entity.get_child_count() > 0:
		$Entity.get_child(0).set_name("ToDelete")
		$Entity.get_child(0).queue_free()
	var e = _entity.instance()
	if e is Replayable:
		e.enable_replay()
	$Entity.set_scale(Vector2(1, 1) * pow(_zoom_mult, _clone_gen))
	$Entity.add_child(e)
	$AnimationPlayer.play("log", -1, 1 / pow(_zoom_mult * REPLAY_SLOW_MULT, _clone_gen))
