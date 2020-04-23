extends BattleAction

func execute(targets):
	assert(initialized)
	if actor.party_member and not targets:
		return false
	
	print("yes")
	
	return true
