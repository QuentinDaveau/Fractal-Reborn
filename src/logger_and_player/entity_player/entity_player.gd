extends Node
# Node dedicated to replay the actions of a defined entity from a given log
# (a log being an Animation)

var _log: Animation


# On ready, plays the log
func _ready() -> void:
	$AnimationPlayer.play("log")


# Sets the log
func set_log(new_log: Animation) -> void:
	_log = new_log
	$AnimationPlayer.add_animation("log", _log)


# Returns the Entity being replayed
func get_entity() -> Node:
	return $Entity.get_child(0)


# Sets the entity to replay
func set_entity(entity: Node) -> void:
	$Entity.add_child(entity)
