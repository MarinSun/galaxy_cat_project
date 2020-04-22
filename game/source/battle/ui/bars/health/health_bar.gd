extends StatBar
class_name HealthBar

func _connect_value_signals(fighter: Fighter) -> void:
	var fighter_stats = fighter.stats
	fighter_stats.connect("health_changed", self, "_on_value_changed")
	fighter_stats.connect("health_depleted", self, "_on_value_depleted")
	
	self.max_value = fighter_stats.max_health
	self.value = fighter_stats.health
