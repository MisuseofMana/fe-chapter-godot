@tool
extends Node2D
class_name AbstractCard

@onready var click_interaction = %ClickInteraction
@onready var card_click_sound = $CardClickSound

@onready var card_base = %CardBase
@onready var card_uses_remaining = $Container/CardUsesRemaining
@onready var suit : AnimatedSprite2D = %Suit

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var card_details : AbstractCardDetails

signal card_selected(card: AbstractCard)

var is_selected : bool = false : 
	set(newValue):
		is_selected = newValue
		if newValue == true:
			card_selected.emit(self)

func _ready():
	suit.frame = card_details.card_type
	update_card_visuals()
	
func update_card_visuals():
	card_uses_remaining.text = str(card_details.power)
	if card_details.power > 0:
		card_base.frame = card_details.power - 1
	else:
		animation_player.animation_set_next('select', 'dissolve')

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
		GameManager.activate_card_action(self)
		animation_player.play('select')

func play_raise_animation(event: InputEvent):
	if event.is_pressed():
		if is_selected:
			unselect_card()
		elif not is_selected:
			get_tree().call_group('player_cards', 'unselect_all_cards')
			select_card()

func reduce_power_by_one():
	if is_selected:
		card_details.power -= 1
		update_card_visuals()
		
func collect_card(passed_card_details: AbstractCardDetails):
	card_details.power += passed_card_details.power
	card_uses_remaining.text = str(card_details.power)
	card_base.frame = card_details.power - 1
