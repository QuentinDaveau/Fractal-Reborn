extends Node

# Node entirely dedicated to log the position of the player. Logs the position, velocity and time
# for each snapshot. Also automatically takes a snapshot when a big difference in the motion of the player
# is detected.

const LOG_RATE_SEC: float = 0.1
const DIFFERENTIAL_THRESHOLD: float = 8000.0

onready var _start_time: int = OS.get_ticks_msec()

var _entity: Node2D
var _logs: Array = []
var _delay: float = 0

var _entity_old_pos: Vector2
var _previous_world_velocity: Vector2 = Vector2.ZERO
var _world_velocity: Vector2 = Vector2.ZERO


func setup(entity: Node2D) -> void:
	_entity = entity


# Takes an initial snapshot when ready
func _ready() -> void:
	if not _entity:
		_entity = owner.get_node("Entity").get_child(0)
	_entity_old_pos = _entity.global_position
	_take_snap()


# Every LOG_RATE_SEC, or when a important change in velocity is detected, takes a snapshot
func _physics_process(delta: float) -> void:
	if delta == 0:
		return
	if not is_instance_valid(_entity):
		return
	_delay -= delta
	_previous_world_velocity = _world_velocity
	_world_velocity = (_entity.global_position - _entity_old_pos) / delta
	_entity_old_pos = _entity.global_position
	if _delay <= 0:
		_take_snap()
		return
	if _previous_world_velocity.distance_to(_world_velocity) / delta >= DIFFERENTIAL_THRESHOLD:
		_take_snap()


#Saves a snapshot
func _take_snap() -> void:
#	_logs.append([OS.get_ticks_msec() - _start_time, _entity.global_position, _entity.get_world_velocity()])
	owner.log_property(_entity, "position", _entity.position)
	_delay = LOG_RATE_SEC
	# DEBUG
	$MotionPredictorDebugger.add_point(_entity.position)


# Returns the saved logs
func get_logs() -> Array:
	return _logs
