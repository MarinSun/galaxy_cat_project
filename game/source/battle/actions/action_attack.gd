extends Action

func execute(targets):
	assert(initialized)
	if actor.party_member and not targets:
		return false
	
#	actor.act(cost)
	
	for target in targets:
#		yield(actor.skin.move_start(), "completed")
		yield(actor.skin.move_to(target), "completed")
#		yield(actor.skin.move_finished(), "completed")
		
		yield(actor.skin.attack(), "completed")
		
		# var target_def = target.stats.vitality if target.skin.get_animation() == "guard" else 0
		var hit = Hit.new(actor.stats.strength, target.stats.vitality)
		target.take_damage(hit)
		yield(actor.get_tree().create_timer(0.5), "timeout")
		
#		yield(actor.skin.move_start(), "completed")
		yield(return_to_start_position(), "completed")
#		yield(actor.skin.move_finished(), "completed")
	
	return true

func can_use() -> bool:
	return actor.stats.stamina >= cost
