extends Control

onready var last_active: Fighter
onready var icons = $fighter_icons
var FighterIcon = preload("res://source/battle/ui/turn_order/fighter_icon.tscn")

func initialize(session: BattleSession, queue: TurnQueue) -> void:
	queue.connect("queue_changed", self, "_on_queue_changed")

func rebuild(fighters: Array, active: Fighter) -> void:
	for icon in icons.get_children():
		icon.queue_free()
	
	for fighter in fighters:
		var new_icon: FighterIcon = FighterIcon.instance()
		icons.add_child(new_icon)
		new_icon.initialize(fighter)

func _on_queue_changed(fighters: Array, active: Fighter) -> void:
	if fighters.size() != icons.get_child_count():
		rebuild(fighters, active)

func _on_battle_ends():
	queue_free()
