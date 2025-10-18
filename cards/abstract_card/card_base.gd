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

func _ready():
	suit.frame = card_details.card_type
	update_card_visuals()
	
func update_card_visuals():
	card_uses_remaining.text = str(card_details.power)
	if card_details.power > 0:
		card_base.frame = card_details.power - 1

func raise_card():
	get_tree().call_group('active_card', 'lower_card')
	add_to_group('active_card')
	card_click_sound.play()
	animation_player.play('select')
	EventBus.selected_card_changed.emit(self.card_details.card_type)

func lower_card():
	remove_from_group('active_card')
	EventBus.card_deselected.emit()
	card_click_sound.play()
	animation_player.play_backwards('select')

func increase_card_use_by(howMuch: int):
	card_details.power += 1
	update_card_visuals()

func collect_card(passed_card_details: AbstractCardDetails):
	card_details.power += passed_card_details.power
	card_uses_remaining.text = str(card_details.power)
	card_base.frame = card_details.power - 1

func on_card_clicked(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_in_group('active_card'):
				EventBus.card_deselected.emit()
				lower_card()
			else: 
				raise_card()
