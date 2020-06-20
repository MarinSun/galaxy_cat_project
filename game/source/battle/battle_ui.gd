extends CanvasLayer

signal action_selected(action)
signal targets_selected(targets)

const action_menu = preload("res://source/battle/ui/action_menu.tscn")

onready var turn_order = $turn_order
onready var status = $party_status
onready var enemy_list = $enemy_list
onready var cursor = $cursor
onready var popup = $popup

func initialize(session: BattleSession, queue: TurnQueue, fighters: Array, group: EnemyGroup):
	turn_order.initialize(session, queue)
	status.initialize(fighters)
	enemy_list.initialize(fighters)
	popup.initialize(fighters, group)
	remove_child(cursor)

func open_actions_menu(fighter: Fighter) -> void:
	var menu = action_menu.instance()
	add_child(menu)
	menu.initialize(fighter)
	menu.open()
	var selected_action: Action = yield(menu, "action_selected")
	emit_signal("action_selected", selected_action)

func select_targets(selectable_fighters: Array) -> void:
	add_child(cursor)
	var targets: Array = yield(cursor.select_targets(selectable_fighters), "completed")
	emit_signal("targets_selected", targets)
	remove_child(cursor)
