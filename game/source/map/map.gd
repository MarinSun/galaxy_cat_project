extends Navigation
class_name Map

signal enemies_encountered(group)
signal dialogue_finished

# onready var dialogue_box
onready var interactives = $interactive_objects

func _ready() -> void:
	for action in get_tree().get_nodes_in_group("map_action"):
		(action as MapAction).initialize(self)

func spawn_party(party) -> void:
	interactives.objects.spawn_party(interactives, party)

func start_encounter(group) -> void:
	emit_signal("enemies_encountered", group.instance())

func play_dialogue(data):
	pass
