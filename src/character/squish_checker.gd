extends Area2D


func _on_SquishChecker_body_entered(body: Node) -> void:
	print("Squish!")
	owner.log_and_free()
