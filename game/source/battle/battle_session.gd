extends Node2D
class_name BattleSession

const FighterNode = preload("res://source/fighter/fighter_template.tscn")

onready var turn_queue = $turn_queue
onready var battle_ui = $combat_ui

var active: bool = false
var party: Array = []

signal battle_ends
signal battle_complete
signal battle_win
signal battle_lose

func initialize(group: EnemyGroup, party: Array) -> void:
	combat_preparation(group, party)
	
	var fighters = turn_queue.get_fighters()
	for fighter in fighters:
		fighter.initialize()
	
	battle_ui.initialize(self, turn_queue, fighters)
	turn_queue.initialize()
	
	battle_start()
#	turn_queue.print_queue()

func combat_preparation(group: EnemyGroup, party_members: Array) -> void:
	for member in group.get_children():
		var enemy: Fighter = member.duplicate()
		turn_queue.add_child(enemy)
		enemy.stats.reset()
	
	var party_spawn = $spawn_position/party
	for i in len(party_members):
		var party_member = party_members[i]
		var spawn_point = party_spawn.get_child(i)
		var fighter: Fighter = party_member.get_fighter_copy()
		fighter.position = spawn_point.position
		fighter.name = party_member.name
		fighter.set_meta("party_member", party_member)
		
		turn_queue.add_child(fighter)
		self.party.append(fighter)
		fighter.ai.set("interface", battle_ui)

func battle_start():
	active = true
	play_turn()

func battle_end():
	emit_signal("battle_ends")

func play_turn() -> void:
	var fighter: Fighter = get_active_fighter()
	var targets: Array
	var action: BattleAction
	
	while not fighter.is_able_to_play():
		turn_queue.skip_turn()
		fighter = get_active_fighter()
	
	fighter.selected = true
	var enemies: Array = get_targets()
	if not enemies:
		battle_end()
		return
	
	action = yield(fighter.ai.choose_action(fighter, enemies), "completed")
	targets = yield(fighter.ai.choose_target(fighter, action, enemies), "completed")
	fighter.selected = false
	
	if targets != []:
		yield(turn_queue.play_turn(action, targets), "completed")
	if active:
		play_turn()

func get_active_fighter() -> Fighter:
	return turn_queue.active_fighter

func get_targets():
	if get_active_fighter().party_member:
		return turn_queue.get_enemies()
	else:
		return turn_queue.get_party()
