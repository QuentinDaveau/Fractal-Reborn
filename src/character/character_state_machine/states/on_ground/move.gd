extends "on_ground.gd"


func enter() -> void:
	print("eeeee")
	if not _input_direction.x:
		emit_signal("finished", "idle")
		return
	print("aaaaaa")
#	ANIMATION_STATE.travel("move")
	.enter()


func handle_input(event) -> void:
	.handle_input(event)
	if not _input_direction.x:
		emit_signal("finished", "idle")


func update(delta) -> void:
	.update(delta)


func _on_pushable_collision() -> void:
	emit_signal("finished", "push")
