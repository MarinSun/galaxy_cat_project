extends Control

onready var popup_window = $popup_window
onready var animation_player = $animation_player

func initialize(fighters: Array, group: EnemyGroup) -> void:
	pass

func display_popup():
	animation_player.play("display")
	yield(animation_player, "animation_finished")
