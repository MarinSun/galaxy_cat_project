extends FighterAI

const DEFAULT_CHANCE = 0.75

func choose_action(actor: Fighter, fighters: Array = []):
	yield(get_tree(), "idle_frame")
	return actor.actions.get_child(0)

func choose_target(actor: Fighter, action: BattleAction, fighters: Array = []):
	yield(get_tree(), "idle_frame")
	var this_chance = randi() % 100
	var target_min_health = fighters[randi() % len(fighters)]

	if this_chance > DEFAULT_CHANCE:
		return [target_min_health]
	
	var min_health = target_min_health.stats.health
	for target in fighters:
		if actor.party_member == target.party_member:
			continue
		
		if target.stats.health < min_health:
			target_min_health = target
		
		return [target_min_health]
