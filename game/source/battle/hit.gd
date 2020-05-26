class_name Hit

var damage = 0

func _init(attack_power: int, defense_power: int, additional_damage: int = 0) -> void:
	damage = max(0, attack_power - defense_power) + additional_damage
