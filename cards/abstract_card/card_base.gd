extends Sprite2D
class_name AbstractCard

@onready var suit: Sprite2D = $Suit
@onready var strength: Sprite2D = $Strength

@export var card : AbstractCardDetails

func _ready():
	suit.texture = card.suit_texture
	strength.texture = card.card_bar_texture
	texture = card.card_texture
