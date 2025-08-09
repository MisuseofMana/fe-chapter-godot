@tool
extends Node2D
class_name AbstractCard

@onready var control: Control = $Control
@onready var card_base: Sprite2D = $Highlight/CardBase
@onready var suit: Sprite2D = $Highlight/Suit
@onready var strength: Sprite2D = $Highlight/Strength

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var card : AbstractCardDetails

var is_selected : bool = false

func _ready():
	suit.texture = card.suit_texture
	card_base.frame = randi_range(0, 7)
	strength.frame = card.power

func unselect_card():
	if is_selected:
		is_selected = false
		animation_player.play_backwards('select')
	
func select_card():
	if not is_selected:
		is_selected = true
		animation_player.play('select')

func play_raise_animation(event: InputEvent):
	if event.is_pressed():
		if is_selected:
			unselect_card()
		elif not is_selected:
			get_tree().call_group('player_cards', 'unselect_card')
			select_card()
		
