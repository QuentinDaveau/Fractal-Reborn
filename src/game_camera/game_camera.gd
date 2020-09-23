extends Camera2D


const SHAKE_THRESHOLD: float = 0.5

var _shake_speed: float = 0.01
var _shake_noise: float = 0.1
var _shake_damp: float = 0.5
var _shake_angular_noise: float = 1
var _shake_amount: Vector2 = Vector2.ZERO
var _shake_angle: float


func _ready() -> void:
	$Shaker.connect("tween_all_completed", self, "_shake_move_completed")


func set_position(new_position: Vector2) -> void:
	global_position = new_position


func add_shake(amount: Vector2, angle: float = 0.0) -> void:
	if sign(_shake_amount.x):
		_shake_amount.x += amount.x * sign(_shake_amount.x)
	else:
		_shake_amount.x += amount.x
	if sign(_shake_amount.y):
		_shake_amount.y += amount.y * sign(_shake_amount.y)
	else:
		_shake_amount.y += amount.y
	if sign(_shake_angle):
		_shake_angle += angle * sign(_shake_angle)
	else:
		_shake_angle = angle
	_shake()


func set_shake(speed: float = -1.0, damp: float = -1.0, noise: float = -1.0, angular_noise: float = -1.0) -> void:
	if speed != -1.0:
		_shake_speed = speed
	if damp != -1.0:
		_shake_damp = damp
	if noise != -1.0:
		_shake_noise = noise
	if angular_noise != -1.0:
		_shake_angular_noise = angular_noise


func _shake_move_completed() -> void:
	if not _shake_amount:
		return
	randomize()
	_shake_amount = (-_shake_amount * (1 - _shake_damp)).rotated(rand_range(-PI/2 * _shake_noise, PI/2 * _shake_noise))
	_shake_angle = (-_shake_angle * (1 - _shake_damp)) + rand_range(- _shake_angular_noise * _shake_angle * 0.5, _shake_angular_noise * _shake_angle * 0.5)
	if _shake_amount.length() < SHAKE_THRESHOLD:
		_shake_amount = Vector2.ZERO
		_shake_angle = 0.0
	_shake()


func _shake() -> void:
	$Shaker.interpolate_property(self, "offset", offset, _shake_amount, _shake_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Shaker.interpolate_property(self, "rotation", rotation, _shake_angle, _shake_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Shaker.start()
