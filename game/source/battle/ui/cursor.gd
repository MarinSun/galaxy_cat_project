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

export var MOVE_DURATION: float = 0.5

func select_targets(fighters: Array) -> Array:
	visible = true
	targets = fighters
	target_index = 0
	target_active = targets[target_index]
	
	cursor.global_transform = target_active.cursor_position
	anim_player.play("idle")
	grab_focus()
	var selected_target: Fighter = yield(self, "target_selected")
	hide()
	if not selected_target:
		return []
	return [selected_target]

func move_to(fighter: Fighter):
	tween.interpolate_property(
		cursor,
		"global_transform",
		cursor.global_transform,
		fighter.cursor_position,
		MOVE_DURATION,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	tween.start()

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
	if not new_target:
		return
	target_active = new_target
	move_to(target_active)

func set_new_index(cur_index: int, is_add: bool) -> int:
	if is_add:
		return (cur_index + 1) % targets.size()
	else:
		return targets.size() - 1 if cur_index < 1 else cur_index - 1
