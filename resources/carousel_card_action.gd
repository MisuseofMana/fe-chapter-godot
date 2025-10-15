extends PathFollow2D
class_name CarouselCardAction

var card_details: AbstractCardDetails
@onready var action_icon = %ActionIcon

func _ready():
	action_icon.texture = card_details.get_texture()
