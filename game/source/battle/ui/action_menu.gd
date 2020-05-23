extends Control

signal action_selected(action)

onready var action_list = $list
onready var tween = $tween

const action_button: = preload("res://source/battle/ui/actions/action_button.tscn")

func initialize(fighter: Fighter) -> void:
	var actions = fighter.actions.get_actions()
	for action in actions:
		var button = action_button.instance()
		action_list.add_child(button)
		
		button.initialize(action)
		button.connect("pressed", self, "_on_action_selected", [action])

func open() -> void:
	show()
	action_list.get_child(0).grab_focus()

func close() -> void:
	tween.interpolate_property(self, "visible", false, true, 0.5)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()

func _on_action_selected(action):
	yield(close(), "completed")
	emit_signal("action_selected", action)
