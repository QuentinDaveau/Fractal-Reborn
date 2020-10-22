extends Replayable
class_name Damageable


export(int, 0, 1000) var _max_health: int = 100

var _current_health: int = _max_health


func damage(amount: int) -> void:
	_current_health -= amount
	if _current_health <= 0:
		if not _is_replay:
			log_and_free()


func heal(amount: int) -> void:
	_current_health = clamp(_current_health + amount, 0, _max_health)
