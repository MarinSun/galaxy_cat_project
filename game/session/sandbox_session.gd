extends Node

signal battle_started

const battle_session = preload("res://source/battle/battle_session.tscn")

onready var party = $party as Party
onready var bgm = $bgm

var battle: BattleSession

export (PackedScene) onready var map
export (PackedScene) onready var enemy_group

func _ready():
	var local_map = map.instance()
	add_child(local_map)
	local_map.spawn_party(party)
	local_map.connect("enemies_encountered", self, "enter_battle")
#	enter_battle(enemy_group.instance())

func enter_battle(group: EnemyGroup):
	
	#
	# Preparation
	#
	
	bgm.battle_1()
	
	battle = battle_session.instance()
	add_child(battle)
	battle.connect("battle_win", self, "_battle_win")
	battle.connect("battle_lose", self, "_battle_lose")
	
	battle.initialize(group, party.get_active_members())
	emit_signal("battle_started")

func _battle_done(battle_stage):
	pass

func _battle_win():
	pass

func _battle_lose():
	pass
