extends MapSprite
class_name SpriteActor

var interactives

onready var pivot = $pivot
onready var anim: SpriteBody = pivot.get_node("sprite_body")

func initialize(interactive_objects):
	interactives = interactive_objects

func change_sprite(exploration_sprite: SpriteBody):
	if anim:
		anim.queue_free()
	anim = exploration_sprite
	pivot.add_child(exploration_sprite)
