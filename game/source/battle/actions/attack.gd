extends BattleAction

func execute(targets):
	assert(initialized)
	if actor.party_member and not targets:
		return false
	
	actor.move_to()

#	for target in targets:
#		print("YES")

	return true
