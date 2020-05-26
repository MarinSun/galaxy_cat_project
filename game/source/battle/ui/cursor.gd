extends Control

signal target_selected(fighter)

onready var cursor = $sprite
onready var anim_player = $sprite/animation
onready var tween = $tween

const DIR_UP = Vector3.FORWARD
const DIR_DOWN = Vector3.BACK
const DIR_LEFT = Vector3.LEFT
const DIR_RIGHT = Vector3.RIGHT

var targets: Array
var target_active = Fighter
var target_index: int

func select_targets(fighters: Array) -> Array:
	visible = true
	targets = fighters
	target_active = targets[0]
	
	target_index = 0
	
	cursor.global_transform.origin = target_active.cursor_position
	anim_player.play("idle")
	grab_focus()
	var selected_target: Fighter = yield(self, "target_selected")
	hide()
	if not selected_target:
		return []
	return [selected_target]

func move_to(fighter: Fighter):
	cursor.global_transform.origin = fighter.cursor_position

func _input(event):
	# Prevents input other than Mouse Button and Accept
	if not event is InputEventMouseButton:
		return
	if not event.is_action_pressed("ui_accept"):
		return
	for fighter in targets:
		if fighter == target_active:
			emit_signal("target_selected", target_active)
		else:
			target_active = fighter
			move_to(target_active)
	accept_event()
	return

func _gui_input(event):
	if not visible:
		return
	
	if event.is_action_pressed("ui_accept"):
		emit_signal("target_selected", target_active)
		accept_event()
	if event.is_action_pressed("ui_cancel"):
		emit_signal("target_selected", null)
		accept_event()
	
	var new_target: Fighter = null
	
	if event.is_action_pressed("ui_up"):
		target_index = set_new_index(target_index, false)
		new_target = targets[target_index]
		accept_event()
	if event.is_action_pressed("ui_down"):
		target_index = set_new_index(target_index, true)
		new_target = targets[target_index]
		accept_event()
	
#	if event.is_action_pressed("ui_up"):
#		new_target = find_closest_target(DIR_UP)
#		print(new_target)
#		accept_event()
#	if event.is_action_pressed("ui_down"):
#		new_target = find_closest_target(DIR_DOWN)
#		accept_event()
#	if event.is_action_pressed("ui_left"):
#		new_target = find_closest_target(DIR_RIGHT)
#		accept_event()
#	if event.is_action_pressed("ui_right"):
#		new_target = find_closest_target(DIR_LEFT)
#		accept_event()

	if not new_target:
		return
	target_active = new_target
	move_to(target_active)

func set_new_index(cur_index: int, is_add: bool) -> int:
	if is_add:
		return (cur_index + 1) % targets.size()
	else:
		return targets.size() - 1 if cur_index < 1 else cur_index - 1

func switch_target(cur_index, switch):
	return (cur_index + switch) % targets.size()

func find_closest_target(direction: Vector3) -> Fighter:
	if targets.size() == 1:
		return targets[0]
	var selected_target: Fighter = null
	var distance_to_selected: float = 0.5
	
	var priority_fighters: Array = []
	var other_fighters: Array = []
	for fighter in targets:
		var to_fighter: Vector3 = fighter.global_transform.origin - target_active.global_transform.origin
		if to_fighter.length() < 1.0:
			continue
		var abs_angle_to_fighter = abs(direction.angle_to(to_fighter))
		if abs_angle_to_fighter > PI / 2.0:
			continue
		if abs_angle_to_fighter < PI / 6.0:
			priority_fighters.append(fighter)
		else:
			other_fighters.append(fighter)
	
	for fighter in priority_fighters:
		var distance: float = fighter.global_transform.origin.distance_to(target_active.global_transform.origin)
		selected_target = fighter
		distance_to_selected = distance
	if selected_target:
		return selected_target
	
	var axis: String = 'x' if direction in [DIR_LEFT, DIR_RIGHT] else 'z'
	var compare_direction: float = direction.x if axis == 'x' else direction.z
	for fighter in other_fighters:
		var to_fighter: Vector3 = fighter.global_transform.origin - target_active.global_transform.origin
		var distance: float = abs(to_fighter.x) if axis == 'x' else abs(to_fighter.z)
		if distance < distance_to_selected:
			selected_target = fighter
			distance_to_selected = distance	
	return selected_target
