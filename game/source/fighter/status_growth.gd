extends Resource
class_name StatusGrowth

export var level_lookup: PoolIntArray
export var max_health_curve: Curve
export var max_stamina_curve: Curve
export var strength_curve: Curve
export var intelligence_curve: Curve
export var vitality_curve: Curve
export var agility_curve: Curve

func create_stats(experience: int) -> CharacterStatus:
	var stats: CharacterStatus = CharacterStatus.new()
	stats.level = get_level(experience)
	stats.max_health = _get_max_health(experience)
	stats.max_stamina = _get_max_stamina(experience)
	stats.strength = _get_strength(experience)
	stats.intelligence = _get_intelligence(experience)
	stats.vitality = _get_vitality(experience)
	stats.agility = _get_agility(experience)
	stats.reset()
	return stats

func get_level(value: int) -> int:
	var max_level: int = len(level_lookup)
	var level: int = 0
	while level + 1 < max_level && value > level_lookup[level + 1]:
		level += 1
	return level

func _get_interpolated_level(value: int = 0) -> float:
	var max_level = len(level_lookup)
	assert(max_level > 0)
	var level: int = get_level(value)
	return float(level) / float(max_level)

func _get_max_health(experience: int) -> int:
	assert(max_health_curve != null)
	var level: float = _get_interpolated_level(experience)
	return int(max_health_curve.interpolate_baked(level))

func _get_max_stamina(experience: int) -> int:
	assert(max_stamina_curve != null)
	var level: float = _get_interpolated_level(experience)
	return int(max_stamina_curve.interpolate_baked(level))

func _get_strength(experience: int) -> int:
	assert(strength_curve != null)
	var level: float = _get_interpolated_level(experience)
	return int(strength_curve.interpolate_baked(level))

func _get_intelligence(experience: int) -> int:
	assert(intelligence_curve != null)
	var level: float = _get_interpolated_level(experience)
	return int(intelligence_curve.interpolate_baked(level))

func _get_vitality(experience: int) -> int:
	assert(vitality_curve != null)
	var level: float = _get_interpolated_level(experience)
	return int(vitality_curve.interpolate_baked(level))

func _get_agility(experience: int) -> int:
	assert(agility_curve != null)
	var level: float = _get_interpolated_level(experience)
	return int(agility_curve.interpolate_baked(level))
