extends Area2D


func check_for_weapon() -> Node2D:
	var closest_weapon: Node2D = null
	for body in get_overlapping_bodies():
		if not closest_weapon:
			closest_weapon = body
			continue
		if closest_weapon.global_position.distance_to(global_position) > body.global_position.distance_to(global_position):
			body = closest_weapon
	return closest_weapon
