extends Node2D

var DEAD_ZONE: float = 0.1

var _held_weapon: Node2D
var _grabbing: bool = false
var _input_direction: Vector2 = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion:
		if event.axis == 2:
			_input_direction.x = event.axis_value
		if event.axis == 3:
			_input_direction.y = event.axis_value
		$WeaponHolder.rotation = _input_direction.angle()
	if _grabbing:
		return
	if event.is_action_pressed("grab_and_drop"):
		_pick_or_drop()
	if event.is_action_pressed("attack"):
		_attack()


func _pick_or_drop() -> void:
	if _held_weapon:
		_drop_weapon()
	else:
		_pick_weapon()


func _pick_weapon() -> void:
	var weapon: Node2D = $WeaponChecker.check_for_weapon()
	if not weapon: 
		return
	_grabbing = true
	_held_weapon = weapon
	_held_weapon.pick(owner)
	yield(_held_weapon, "disappeared")
	$WeaponHolder.remote_path = $WeaponHolder.get_path_to(_held_weapon)
	$WeaponHolder.force_update_cache()
	_held_weapon.appear()
	_grabbing = false


func _drop_weapon() -> void:
	_held_weapon.drop()
	_held_weapon = null
	$WeaponHolder.remote_path = ""
	$WeaponHolder.force_update_cache()


func _attack() -> void:
	if not _held_weapon:
		return
	_held_weapon.attack()
