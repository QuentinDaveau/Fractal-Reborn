extends Node
# Node dedicated to replay the actions of a defined entity from a given log
# (a log being an Animation)

var _log: Animation
var _entity: Resource


# On ready, plays the log
func _ready() -> void:
	$AnimationPlayer.play("log", -1, 0.5)


# Sets the log and its associated entity
func setup(new_log: Animation, entity: Resource) -> void:
	_log = new_log
	_entity = entity
	$AnimationPlayer.add_animation("log", _log)
	var e = _entity.instance()
	if e is Replayable:
		e.enable_replay()
	$Entity.add_child(e)


# Returns the Entity being replayed
func get_entity() -> Node:
	return $Entity.get_child(0)


# Resets the entity
func refresh() -> void:
	$Entity.get_child(0).queue_free()
	var e = _entity.instance()
	if e is Replayable:
		e.enable_replay()
	$Entity.add_child(e)
	$AnimationPlayer.play("log")
