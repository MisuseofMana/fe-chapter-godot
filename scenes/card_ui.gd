extends CanvasLayer
class_name CardGui

const CARD_BASE = preload("res://cards/abstract_card/card_base.tscn")

@onready var anims: AnimationPlayer = $CardGuiAnimations
@onready var ui_slide_sound = $UISlideSound

@export var deck : Array[AbstractCardDetails]
@onready var slots: Node2D = $AnimNode/PlayerSlots
@onready var card_container: Node2D = $AnimNode/CardContainer

var overflow_cards : Array[AbstractCardDetails] = []
var active_card : AbstractCard = null
var drawer_visible : bool = false

signal card_action_primed(card_type : AbstractCardDetails.CARD_TYPE)
signal card_action_unprimed(card_type : AbstractCardDetails.CARD_TYPE)

func _ready() -> void:
	var current_index : int = 0
	for card : AbstractCardDetails in deck:
		var baseCard : AbstractCard = CARD_BASE.instantiate()
		baseCard.card_details = card
		card_container.add_child(baseCard)
		baseCard.card_activated.connect(handle_card_activated)
		baseCard.global_position = slots.get_children()[current_index].global_position
		current_index += 1

func card_is_active(card: AbstractCard) -> bool:
	return active_card == card

func handle_card_activated(clicked_card: AbstractCard):
#	three states, card picked, card swapped, card unpicked
	if card_is_active(clicked_card):
		clicked_card.lower_card()
		card_action_unprimed.emit(clicked_card.card_details.card_type)
		active_card = null
	else:
		if active_card:
			active_card.lower_card()
			card_action_unprimed.emit(active_card.card_details.card_type)
		clicked_card.raise_card()
		active_card = clicked_card
		card_action_primed.emit(clicked_card.card_details.card_type)

func toggle_drawer():
	ui_slide_sound.play()
	if drawer_visible:
		anims.play('hide_drawer')
		drawer_visible = false
	else:
		anims.play_backwards('hide_drawer')
		drawer_visible = true

func consume_card(card_type : AbstractCardDetails.CARD_TYPE):
	for card : AbstractCard in get_children():
		if card.card_details.card_type == card_type:
			card.consume_one()

func aquire_new_card(collected_card : AbstractCardDetails):
	var number_of_cards_in_inventory = card_container.get_children().size()
	var number_of_slots_in_inventory = slots.get_children().size()
	if number_of_cards_in_inventory < number_of_slots_in_inventory:
		var open_slot_index = number_of_cards_in_inventory
		var baseCard : AbstractCard = CARD_BASE.instantiate()
		baseCard.card_details = collected_card
		card_container.add_child(baseCard)
		baseCard.global_position = slots.get_children()[open_slot_index].global_position
	else:
		overflow_cards.push_front(collected_card)
	
