extends YSort
class_name TurnQueue

signal queue_changed

onready var active_fighter: Fighter
var last_action_canceled: bool = false

func initialize() -> void:
	var fighters = get_fighters()
	fighters.sort_custom(self, 'sort_fighters')
	for fighter in fighters:
		fighter.raise()
	active_fighter = get_child(0)
	emit_signal("queue_changed", get_fighters(), active_fighter)
	
func play_turn(action: BattleAction, targets: Array):
	if not last_action_canceled:
		pass
	action.initialize(active_fighter)
	var hit_target = yield(action.execute(targets), "completed")
	if not hit_target:
		last_action_canceled = true
		return
	last_action_canceled = false
	_next_fighter()

func skip_turn():
	_next_fighter()

func _next_fighter():
	var next_fighter_index: int = (active_fighter.get_index() + 1) % get_child_count()
	active_fighter = get_child(next_fighter_index)
	emit_signal('queue_changed', get_fighters(), active_fighter)

func get_fighters():
	return get_children()

func get_party():
	return _get_targets(true)

func get_enemies():
	return _get_targets(false)

func _get_targets(in_party: bool = false) -> Array:
	var targets: Array = []
	for child in get_children():
		if child.party_member == in_party && child.stats.health > 0:
			targets.append(child)
	return targets

static func sort_fighters(a: Fighter, b: Fighter) -> bool:
	return a.stats.agility > b.stats.agility

func print_queue():
	var string: String
	for fighter in get_children():
		string += fighter.name + "(%s)" % fighter.stats.agility + " "
	print(string)
