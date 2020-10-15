extends Replayable

signal disappeared()

const SNAP_VECT: Vector2 = Vector2.DOWN * 50
const GROUND_VECT: Vector2 = Vector2.UP

onready var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var _velocity: Vector2 = Vector2.ZERO
var _picked: bool = false


func _physics_process(delta: float) -> void:
	if _picked:
		return
	_velocity.y += GRAVITY * delta
	_velocity = move_and_slide_with_snap(_velocity, SNAP_VECT, GROUND_VECT)


func attack() -> void:
	$ShootManager.shoot()


func pick(picker_body: PhysicsBody2D) -> void:
	$CollisionPolygon2D.disabled = true
	_picked = true
	_disappear()


func appear() -> void:
	$Tween.interpolate_property(self, "scale", scale, Vector2(1, 1), 0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()


func drop() -> void:
	$CollisionPolygon2D.disabled = false
	_picked = false


func _disappear() -> void:
	$Tween.interpolate_property(self, "scale", scale, Vector2(0, 0), 0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	emit_signal("disappeared")
