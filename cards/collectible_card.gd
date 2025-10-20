extends Node2D
class_name CollectibleCard

@onready var anims = $CollectibleAnimations
@onready var card_suit_sprite = $CardSprite/CardSuitSprite

var card_details : Action = null

func _ready():
	set_card_visuals()

func set_card_visuals():
	card_suit_sprite.frame = card_details.card_type
	
func reveal_self():
	anims.play('reveal_collectible')

func _on_collectible_animations_animation_finished(anim_name):
	if anim_name == 'reveal_collectible':
		EventBus.new_card_aquired.emit(card_details)
		queue_free()
