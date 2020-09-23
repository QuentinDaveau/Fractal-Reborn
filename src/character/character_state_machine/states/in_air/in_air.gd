extends "../character_state.gd"


func enter() -> void:
	owner.set_snap(false)
	owner.set_to_world_velocity()
	.enter()


func handle_input(event) -> void:
	.handle_input(event)


func update(delta) -> void:
	.update(delta)
	if owner.is_on_floor():
		emit_signal("finished", "previous")
