extends PathFollow2D
class_name CarouselCardAction

var card_details: AbstractCardDetails
@onready var action_icon = %ActionIcon
@onready var card_selection_indicator = %CardSelectionIndicator
@onready var anims = %AnimationPlayer

func _ready():
	action_icon.texture = card_details.get_texture()
	
func raise_card():
	if not card_details.card_is_active:
		anims.play('raise_card')
		card_details.card_is_active = true
	
func lower_card():
	if card_details.card_is_active:
		anims.play_backwards('raise_card')
		card_details.card_is_active = false
