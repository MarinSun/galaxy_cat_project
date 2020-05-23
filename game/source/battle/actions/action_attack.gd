extends Action

func execute(targets):
	assert(initialized)
	if actor.party_member and not targets:
		return false
	
	for target in targets:
		pass
	
	return true
