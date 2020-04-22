extends YSort

export var party_scene: PackedScene

var party_members: = []
var party

func spawn_party(party: Object) -> void:
	self.party = party
	var pawn_previous = null
	var party_size = min(get_child_count(), party.PARTY_SIZE) - 1
