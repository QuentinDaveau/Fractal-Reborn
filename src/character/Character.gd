extends KinematicBody2D

const WALL_ANGLE: float = PI/4
const SNAP_VECT: Vector2 = Vector2.DOWN * 50
const GROUND_VECT: Vector2 = Vector2(0, -1)

var _velocity: Vector2 = Vector2.ZERO


func add_velocity(velocity_vector: Vector2) -> void:
	_velocity += velocity_vector


func get_velocity() -> Vector2:
	return _velocity


func move(delta: float, velocity: Vector2) -> void:
	_velocity = move_and_slide_with_snap(velocity, SNAP_VECT, GROUND_VECT)
