extends KinematicBody2D

const WALL_ANGLE: float = PI/4
const SNAP_VECT: Vector2 = Vector2.DOWN * 50
const GROUND_VECT: Vector2 = Vector2.UP

onready var _old_pos = global_position

var _velocity: Vector2 = Vector2.ZERO
var _snap: Vector2 = SNAP_VECT
var _world_velocity: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	_world_velocity = (global_position - _old_pos) / delta
	_old_pos = global_position


func set_snap(enable: bool = true) -> void:
	if enable:
		_snap = SNAP_VECT
	else:
		_snap = Vector2.ZERO


func set_to_world_velocity() -> void:
	_velocity = _world_velocity


func add_velocity(velocity_vector: Vector2) -> void:
	_velocity += velocity_vector


func get_velocity() -> Vector2:
	return _velocity


func move(delta: float, velocity: Vector2) -> void:
	_velocity = move_and_slide_with_snap(velocity, _snap, GROUND_VECT)
