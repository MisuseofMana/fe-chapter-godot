extends Node

var movement_locked : bool = false

signal CARD_CLICKED(card: AbstractCard)
signal ACTION_OCCURED(interactable_name : AbstractCardDetails.CARD_TYPE)
signal NEW_ACTION_PRIMED(card_type: AbstractCardDetails.CARD_TYPE)
signal ACTION_UNPRIMED(card_type: AbstractCardDetails.CARD_TYPE)

func deactivate_neighbor_squares():
	get_tree().call_group('interactable_items', 'handle_within_reach_status')
		
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
