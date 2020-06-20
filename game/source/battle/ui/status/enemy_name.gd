extends Label

func initialize(fighter: Fighter):
	text = fighter.name
	_connect_value_signal(fighter)

func _connect_value_signal(fighter: Fighter):
	var fighter_stats = fighter.stats
	
	fighter_stats.connect("health_depleted", self, "_on_enemy_dead")

func _on_enemy_dead():
	modulate = "#555555"
