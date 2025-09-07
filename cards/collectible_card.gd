extends Node2D
class_name CollectibleCard

@onready var anims = $CollectibleAnimations
@onready var card_suit_sprite = $CardSprite/CardSuitSprite
@onready var card_power = $CardSprite/CardPower

var card_details : AbstractCardDetails = null

func _ready():
	set_card_visuals()

func set_card_visuals():
	card_suit_sprite.texture = card_details.get_card_suit()
	card_power.text = str(card_details.power)
	
func reveal_self():
	anims.play('reveal_collectible')

func _on_collectible_animations_animation_finished(anim_name):
	if anim_name == 'reveal_collectible':
		GameManager.add_card_to_inventory(card_details)
		queue_free()
