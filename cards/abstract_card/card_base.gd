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

var is_active : bool = false

signal card_activated(card: AbstractCard)

func _ready():
	suit.frame = card_details.card_type
	update_card_visuals()
	
func update_card_visuals():
	card_uses_remaining.text = str(card_details.power)
	if card_details.power > 0:
		card_base.frame = card_details.power - 1
	else:
		animation_player.animation_set_next('select', 'dissolve')

func raise_card():
	card_click_sound.play()
	animation_player.play('select')

func lower_card():
	card_click_sound.play()
	animation_player.play_backwards('select')

func consume_one():
	card_details.power -= 1
	update_card_visuals()

func collect_card(passed_card_details: AbstractCardDetails):
	card_details.power += passed_card_details.power
	card_uses_remaining.text = str(card_details.power)
	card_base.frame = card_details.power - 1

func on_card_clicked(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			is_active = true
			card_activated.emit(self)
