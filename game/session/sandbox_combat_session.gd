extends Node

onready var party = $party as Party
onready var battle = $battle_session
onready var bgm = $bgm

export (PackedScene) onready var enemy_group

func _ready():
	battle.initialize(enemy_group.instance(), party.get_active_members())
