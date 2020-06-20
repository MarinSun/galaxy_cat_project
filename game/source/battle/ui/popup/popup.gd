extends Control

const popup_window = preload("res://source/battle/ui/popup/popup_window.tscn")

func initialize(fighters: Array, group: EnemyGroup) -> void:
	display_encounter(group)

func display_encounter(group):
	var popup = popup_window.instance()
	popup.encounter_message(group)
