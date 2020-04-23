extends Control

signal target_selected(fighter)

onready var anim_player = $sprite/animation
onready var tween = $tween

export var MOVE_DURATION: float = 0.1

const DIR_UP = Vector2.UP
const DIR_LEFT = Vector2.LEFT
const DIR_RIGHT = Vector2.RIGHT
const DIR_DOWN = Vector2.DOWN

var targets: Array
var target_active: Fighter

func select_targets(fighters: Array) -> Array:
	visible = true
	targets = fighters
	target_active = targets[0]
#	rect_scale.x = 1.0 if target_active.party_member else -1.0
	rect_global_position = target_active.target_global_position
	anim_player.play("idle")
	grab_focus()
	var selected_target: Fighter = yield(self, "target_selected")
	hide()
	if not selected_target:
		return []
	return [selected_target]

func move_to(fighter: Fighter):
	tween.interpolate_property(
		self,
		"rect_global_position",
		rect_global_position,
		fighter.target_global_position,
		MOVE_DURATION,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	tween.start()

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if not event.is_action_pressed("ui_accept"):
		return
	for fighter in targets:
		if not fighter.has_point(event.position):
			continue
		if fighter == target_active:
			emit_signal("target_selected", target_active)
		else:
			target_active = fighter
			move_to(target_active)
	accept_event()
	return

func _gui_input(event):
	if !visible:
		return
	
	if event.is_action_pressed("ui_accept"):
		emit_signal("target_selected", target_active)
		accept_event()
	if event.is_action_pressed("ui_cancel"):
		emit_signal("target_selected", null)
		accept_event()
	
	var new_target: Fighter = null
	if event.is_action_pressed("ui_left"):
		new_target = find_closest_target(DIR_LEFT)
		accept_event()
	if event.is_action_pressed("ui_up"):
		new_target = find_closest_target(DIR_UP)
		accept_event()
	if event.is_action_pressed("ui_right"):
		new_target = find_closest_target(DIR_RIGHT)
		accept_event()
	if event.is_action_pressed("ui_down"):
		new_target = find_closest_target(DIR_DOWN)
		accept_event()
	if not new_target:
		return
	target_active = new_target
	move_to(target_active)

func find_closest_target(direction: Vector2) -> Fighter:
	if targets.size() == 1:
		return targets[0]
	var selected_target: Fighter = null
	var distance_to_selected: float = 100000.0
	
	var priority_fighters: Array = []
	var other_fighters: Array = []
	for fighter in targets:
		var to_fighter: Vector2 = fighter.global_position - target_active.global_position
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
		var distance: float = fighter.global_position.distance_to(target_active.global_position)
		selected_target = fighter
		distance_to_selected = distance
	if selected_target:
		return selected_target
	
	var axis: String = 'x' if direction in [DIR_LEFT, DIR_RIGHT] else 'y'
	var compare_direction: float = direction.x if axis == 'x' else direction.y
	for fighter in other_fighters:
		var to_fighter: Vector2 = fighter.global_position - target_active.global_position
		var distance: float = abs(to_fighter.x) if axis == 'x' else abs(to_fighter.y)
		if distance < distance_to_selected:
			selected_target = fighter
			distance_to_selected = distance	
	return selected_target
