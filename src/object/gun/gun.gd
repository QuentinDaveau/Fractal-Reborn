extends Replayable

signal disappeared()


func attack() -> void:
	$ShootManager.shoot()


func pick(picker_body: PhysicsBody2D) -> void:
	$CollisionPolygon2D.disabled = true
	_disappear()


func appear() -> void:
	$Tween.interpolate_property(self, "scale", scale, Vector2(1, 1), 0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()


func drop() -> void:
	$CollisionPolygon2D.disabled = false


func _disappear() -> void:
	$Tween.interpolate_property(self, "scale", scale, Vector2(0, 0), 0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	emit_signal("disappeared")
