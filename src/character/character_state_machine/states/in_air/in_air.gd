extends "../character_state.gd"


func enter() -> void:
	.enter()


func handle_input(event) -> void:
	.handle_input(event)


func update(delta) -> void:
	.update(delta)
	if owner.is_on_floor():
		emit_signal("finished", "previous")
