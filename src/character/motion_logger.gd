extends Node

# Node entirely dedicated to log the position of the player. Logs the position, velocity and time
# for each snapshot. Also automatically takes a snapshot when a big difference in the motion of the player
# is detected.

const LOG_RATE_SEC: float = 0.1
const DIFFERENTIAL_THRESHOLD: float = 8000.0

onready var _start_time: int = OS.get_ticks_msec()

var _logs: Array = []
var _delay: float = 0
var _previous_world_velocity: Vector2 = Vector2.ZERO


# Takes an initial snapshot when ready
func _ready() -> void:
	_take_snap()
	# Debug


# Every LOG_RATE_SEC, or when a important change in velocity is detected, takes a snapshot
func _process(delta: float) -> void:
	if delta == 0:
		return
	_delay -= delta
	if _delay <= 0:
		_take_snap()
		_previous_world_velocity = owner.get_world_velocity()
		return
	if _previous_world_velocity.distance_to(owner.get_world_velocity()) / delta >= DIFFERENTIAL_THRESHOLD:
		_take_snap()
	_previous_world_velocity = owner.get_world_velocity()


#Saves a snapshot
func _take_snap() -> void:
	_logs.append([OS.get_ticks_msec() - _start_time, owner.global_position, owner.get_world_velocity()])
	_delay = LOG_RATE_SEC


# Debug
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		print(_logs)
		get_tree().quit() # default behavior
