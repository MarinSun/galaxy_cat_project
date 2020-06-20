extends Spatial

export var party_scene: PackedScene

const Explorer = preload("res://source/exploration/sprite_explorer.tscn")

var party_members := []
var party

func spawn_party(interactives, party: Object):
	self.party = party
	var party_leader = party.get_child(0)
	spawn_explorer(party_leader, interactives)

func spawn_explorer(party_member: PartyMember, interactives: InteractiveObjects):
#	if party_member.exploration_sprite != null:
	var explorer = Explorer.instance()
	explorer.name = party_member.name
	explorer.global_transform = interactives.spawn_point.global_transform
	explorer.initialize(interactives)
	add_child(explorer)
	explorer.change_sprite(party_member.get_exploration_sprite())
	return explorer
