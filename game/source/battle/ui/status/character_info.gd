extends "res://source/battle/ui/status/status_template.gd"
class_name CharacterInfo

func _connect_value_signals(fighter: Fighter) -> void:
	var fighter_stats = fighter.stats
	fighter_stats.connect("health_changed", self, "_on_hp_changed")
	fighter_stats.connect("stamina_changed", self, "_on_sp_changed")
	
	self.hp_value = fighter_stats.health
	self.hp_max = fighter_stats.max_health
	self.sp_value = fighter_stats.stamina
	self.sp_max = fighter_stats.max_stamina
