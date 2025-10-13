extends CanvasLayer
class_name CardGui

const CARD_BASE = preload("res://cards/abstract_card/card_base.tscn")

@onready var anims: AnimationPlayer = $CardGuiAnimations
@onready var ui_slide_sound = $UISlideSound

@export var deck : Array[AbstractCardDetails]
@onready var slots: Node2D = $AnimNode/PlayerSlots
@onready var card_container: Node2D = $AnimNode/CardContainer

var overflow_cards : Array[AbstractCardDetails] = []
var drawer_visible : bool = false

func _ready() -> void:
	var current_index : int = 0
	for card : AbstractCardDetails in deck:
		var baseCard : AbstractCard = CARD_BASE.instantiate()
		baseCard.card_details = card
		card_container.add_child(baseCard)
		baseCard.global_position = slots.get_children()[current_index].global_position
		current_index += 1
	EventBus.new_card_aquired.connect(aquire_new_card)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('show_and_hide_card_drawer'):
		toggle_drawer()
	if event.is_action_pressed('cycle_cards_left'):
		select_previous_card()
	if event.is_action_pressed('cycle_cards_right'):
		select_next_card()

func select_previous_card():
	if not drawer_visible:
		toggle_drawer()
	var active_card_index = get_active_card_index()
	var target_card : AbstractCard
	if active_card_index == null or active_card_index <= 0:
		var last_card_index : int = card_container.get_child_count() - 1
		target_card = card_container.get_child(last_card_index)
		if target_card.has_method('raise_card'):
			target_card.raise_card()
	elif active_card_index > 0:
		target_card = card_container.get_child(active_card_index - 1)
		target_card.raise_card()

func select_next_card():
	if not drawer_visible:
		toggle_drawer()
	var active_card_index = get_active_card_index()
	var target_card : AbstractCard
	if active_card_index == null or active_card_index == card_container.get_child_count() - 1:
		target_card = card_container.get_child(0)
		target_card.raise_card()
	elif active_card_index < card_container.get_child_count() - 1:
		target_card = card_container.get_child(active_card_index + 1)
		target_card.raise_card()

func get_active_card_index() -> int:
	var allCards = card_container.get_children()
	var active_card = get_tree().get_first_node_in_group('active_card')
	var indexOfActiveCard = allCards.find(active_card)
	return indexOfActiveCard

func toggle_drawer():
	ui_slide_sound.play()
	if drawer_visible:
		if get_active_card_index() > -1:
			get_tree().call_group('active_card', 'lower_card')
		else:
			anims.play('hide_drawer')
			drawer_visible = false
		EventBus.card_deselected.emit()
	else:
		anims.play_backwards('hide_drawer')
		drawer_visible = true

func aquire_new_card(collected_card : AbstractCardDetails):
	var existing_card_matching_type : AbstractCard
	for card: AbstractCard in card_container.get_children():
		if card.card_details.card_type == collected_card.card_type:
			card.increase_card_use_by(collected_card.power)
			return
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
	
