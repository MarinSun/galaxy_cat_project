extends Resource
class_name CharacterStatus

signal health_changed(new_health, old_health)
signal health_depleted()
signal stamina_changed(new_stamina, old_stamina)
signal stamina_depleted()

var modifiers = {}

var level: int
var health: int
var stamina: int

export var max_health: int = 1 setget set_max_health, _get_max_health
export var max_stamina: int = 1 setget set_max_stamina, _get_max_stamina
export var strength: int = 1 setget , _get_strength
export var intelligence: int = 1 setget , _get_intelligence
export var vitality: int = 1 setget , _get_vitality
export var agility: int = 1 setget , _get_agility

func reset():
	health = self.max_health
	stamina = self.max_stamina

func copy() -> CharacterStatus:
	var copy = duplicate()
	copy.health = health
	copy.stamina = stamina
	return copy

func take_damage(hit: Hit):
	var old_health = health
	health -= hit.damage
	health = max(0, health)
	emit_signal("health_changed", health, old_health)
	if health == 0:
		emit_signal("health_depleted")

func act(cost: int):
	var old_stamina = stamina
	stamina -= cost
	health = max(0, stamina)
	emit_signal("stamina_changed", stamina, old_stamina)

func play_turn():
	var old_stamina = stamina
	stamina = max_stamina
	emit_signal("stamina_changed", stamina, old_stamina)

func _get_level() -> int:
	return level

#
# Max Health
#

func set_max_health(value: int) -> void:
	if value == null:
		return
	max_health = max(1, value)

func _get_max_health() -> int:
	return max_health

#
# Max Stamina
#

func set_max_stamina(value: int) -> void:
	if value == null:
		return
	max_stamina = max(1, value)

func _get_max_stamina() -> int:
	return max_stamina

#
# Other Stats
#

func _get_strength() -> int:
	return strength

func _get_intelligence() -> int:
	return intelligence

func _get_vitality() -> int:
	return vitality

func _get_agility() -> int:
	return agility
