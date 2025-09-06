@tool
extends Node2D
class_name AbstractCard

@onready var click_interaction = %ClickInteraction
@onready var card_click_sound = $CardClickSound

@onready var card_base = %CardBase
@onready var strength = %Strength
@onready var suit = %Suit

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var card : AbstractCardDetails

var is_selected : bool = false
var card_position : int = 0

func _ready():
	suit.texture = card.get_card_suit()
	card_base.frame = randi_range(0, 7)
	strength.frame = card.power

func unselect_card():
	if is_selected:
		is_selected = false
		card_click_sound.play()
		GameManager.deactivate_card_action()
		animation_player.play_backwards('select')
	
func select_card():
	if not is_selected:
		is_selected = true
		card_click_sound.play()
		GameManager.activate_card_action(card.card_type)
		animation_player.play('select')

func play_raise_animation(event: InputEvent):
	if event.is_pressed():
		if is_selected:
			unselect_card()
		elif not is_selected:
			get_tree().call_group('player_cards', 'unselect_all_cards')
			select_card()
		
