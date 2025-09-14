extends Node

var movement_locked : bool = false

signal CARD_CLICKED(card: AbstractCard)
signal ACTION_OCCURED(interactable_name : AbstractCardDetails.CARD_TYPE)
signal ACTION_PRIMED(card_type: AbstractCardDetails.CARD_TYPE)
signal ACTION_UNPRIMED

func activate_neighbor_squares(abstract_card : AbstractCard):
	for ray : RayCast2D in get_tree().get_nodes_in_group('player_rays'):
		if ray.is_colliding():
			var interactable : Node2D = ray.get_collider().owner
			if interactable is Interactable:
				interactable.handle_within_reach_status(abstract_card.card_details.card_type)

func deactivate_neighbor_squares():
	get_tree().call_group('interactable_items', 'handle_within_reach_status')

func show_corresponding_interactable_icons(abstract_card : AbstractCard) -> void:
	movement_locked = true
	get_tree().call_group('interactable_item', 'handle_interaction_icon_visibility', abstract_card.card_details.card_type)
	activate_neighbor_squares(abstract_card)
		
func hide_interaction_icons():
	movement_locked = false
	get_tree().call_group('interactable_item', 'handle_interaction_icon_visibility')
	
func add_card_to_inventory(card : AbstractCardDetails):
	for inventory_card : AbstractCard in get_tree().get_nodes_in_group('player_cards'):
		if inventory_card.card_details.card_type == card.card_type:
			inventory_card.collect_card(card)
			return
	var card_gui : CardGui = get_tree().get_first_node_in_group('card_gui')
	card_gui.aquire_new_card(card)
