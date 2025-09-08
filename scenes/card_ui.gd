extends CanvasLayer
class_name CardGui

const CARD_BASE = preload("res://cards/abstract_card/card_base.tscn")

@onready var anims: AnimationPlayer = $CardGuiAnimations
@onready var ui_slide_sound = $UISlideSound

@export var deck : Array[AbstractCardDetails]
@onready var slots: Node2D = $AnimNode/PlayerSlots
@onready var card_container: Node2D = $AnimNode/CardContainer
			
var selected_card : AbstractCard = null
var drawer_visible : bool = false

func _ready() -> void:
	var current_index : int = 0
	for card : AbstractCardDetails in deck:
		var baseCard : AbstractCard = CARD_BASE.instantiate()
		baseCard.card_details = card
		card_container.add_child(baseCard)
		baseCard.global_position = slots.get_children()[current_index].global_position
		current_index += 1
		
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed('ToggleCards'):
		toggle_drawer()
	if Input.is_action_just_pressed('cycle_cards_left'):
		if selected_card:
			pass
#		if no card is selected:
#			select the right most card
#		otherwise select the card at one index lower than the currently selected card
	if Input.is_action_just_pressed('cycle_cards_left'):
		pass
		#if no card is selected
#			select the left most card
#		otherwise selext the card at one index higher
	
func toggle_drawer():
	ui_slide_sound.play()
	if drawer_visible:
		anims.play('hide_drawer')
		drawer_visible = false
	else:
		anims.play_backwards('hide_drawer')
		drawer_visible = true
		
func unselect_all_cards():
	for card : AbstractCard in card_container.get_children():
		card.unselect_card()

func decrease_used_card_value():
	for card : AbstractCard in card_container.get_children():
		if card.is_selected:
			card.reduce_power_by_one()
