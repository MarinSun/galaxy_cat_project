extends Action

export var FAIL_RATE = 0.2

func execute(targets):
	var chance: float = rand_range(0.0, 1.0)
	if chance > FAIL_RATE:
		print("You escaped")
	return true
