extends Replayable

const BULLET_ENABLE_DIST: int = 30

export(int, 0, 1000) var _hit_damage: int = 25

onready var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var _spawn_position: Vector2 = global_position

var _velocity: Vector2 = Vector2.ZERO
var is_being_shot: bool = true


func enable_replay() -> void:
	.enable_replay()


func set_velocity(velocity: Vector2) -> void:
	_velocity = velocity


func _enter_tree() -> void:
	if _is_replay:
		return
	rotation = _velocity.angle()
	_spawn_position = global_position


func _physics_process(delta: float) -> void:
	if _is_replay:
		return
	if is_being_shot:
		if _spawn_position.distance_to(global_position) > BULLET_ENABLE_DIST:
			collision_mask += 2
			is_being_shot = false
	_velocity.y += GRAVITY * delta
	move_and_collide(_velocity * delta)


func _on_Timer_timeout() -> void:
	if _is_replay:
		return
	log_and_free()


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Damageable:
		body.damage(_hit_damage)
	if not _is_replay:
		log_and_free()
	else:
		queue_free()
