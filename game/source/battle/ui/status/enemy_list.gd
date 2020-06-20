extends Control

const name_label: = preload("res://source/battle/ui/status/enemy_name.tscn")

onready var list = $list

func initialize(fighters: Array) -> void:
	for fighter in fighters:
		if not fighter.party_member:
			var enemy = name_label.instance()
			list.add_child(enemy)
			enemy.initialize(fighter)
