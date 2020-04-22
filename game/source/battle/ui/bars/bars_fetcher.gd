extends Node

var health_bar = preload("res://source/battle/ui/bars/health/health_bar.tscn")
var stamina_bar = preload("res://source/battle/ui/bars/stamina/stamina_bar.tscn")

func initialize(fighters: Array) -> void:
	for fighter in fighters:
		create_health(fighter)
		create_stamina(fighter)

func create_health(fighter: Fighter) -> void:
	var health = health_bar.instance()
	fighter.bars.add_child(health)
	health.initialize(fighter)

func create_stamina(fighter: Fighter) -> void:
	var stamina = stamina_bar.instance()
	fighter.bars.add_child(stamina)
	stamina.initialize(fighter)
