extends AI

var interface: Node

func choose_action(fighter: Fighter, fighters: Array = []):
	interface.open_actions_menu(fighter)
	return yield(interface, "action_selected")

func choose_target(fighter: Fighter, action: Action, fighters: Array = []):
	match action.target:
		0:
			# Self Target
			interface.select_targets([fighter])
			return yield(interface, "targets_selected")
		1:
			# Single Enemy Target
			var selectables = []
			for selectable in fighters:
				if not selectable.party_member and selectable.is_able_to_play():
					selectables.append(selectable)
			interface.select_targets(selectables)
			return yield(interface, "targets_selected")
		3:
			# Single Ally Target
			var selectables = []
			for selectable in fighters:
				if selectable.party_member:
					selectables.append(selectable)
			interface.select_targets(selectables)
			return yield(interface, "targets_selected")
		_:
			interface.select_targets(fighters)
			return yield(interface, "targets_selected")
