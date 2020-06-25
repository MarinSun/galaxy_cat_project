extends Navigation
class_name Map

signal enemies_encountered(group)
signal dialogue_finished

# onready var dialogue_box
onready var interactives = $interactive_objects

func _ready() -> void:
	pass

func spawn_party(party) -> void:
	interactives.objects.spawn_party(interactives, party)

func start_encounter(group) -> void:
	emit_signal("enemies_encountered", group.instance())

func play_dialogue(data):
	pass
