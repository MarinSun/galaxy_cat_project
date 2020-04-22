extends StatBar
class_name StaminaBar

func _connect_value_signals(fighter: Fighter) -> void:
	var fighter_stats = fighter.stats
	fighter_stats.connect("stamina_changed", self, "_on_value_changed")
	fighter_stats.connect("stamina_depleted", self, "_on_value_depleted")
	
	self.max_value = fighter_stats.max_stamina
	self.value = fighter_stats.stamina
	
	print(self.value)
