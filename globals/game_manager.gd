extends Node

var active_card : AbstractCard = null
var movement_locked : bool = false

func activate_card_action(abstract_card : AbstractCard) -> void:
	active_card = abstract_card
	movement_locked = true
	for interactable : Interactable in get_tree().get_nodes_in_group('interactable_item'):
		if interactable.interactable_name == active_card.card_details.card_type:
			interactable.show_icon()
	activate_neighbor_squares()
	
func activate_neighbor_squares():
	for ray : RayCast2D in get_tree().get_nodes_in_group('player_rays'):
		if ray.is_colliding():
			var subject : Node2D = ray.get_collider().owner
			if subject is Interactable:
				if subject.interactable_name == active_card.card_details.card_type:
					subject.activate_interactability()
		
func deactivate_card_action():
	movement_locked = false
	active_card = null
	get_tree().call_group('player_cards', 'unselect_card')
	for interactable : Interactable in get_tree().get_nodes_in_group('interactable_item'):
		interactable.deactivate_interactability()
		interactable.hide_icon()

func reduce_used_card_value():
	active_card.reduce_power_by_one()
	deactivate_card_action()
	
func add_card_to_inventory(card : AbstractCardDetails):
	for inventory_card : AbstractCard in get_tree().get_nodes_in_group('player_cards'):
		if inventory_card.card_details.card_type == card.card_type:
			inventory_card.collect_card(card)
			return
	var card_gui : CardGui = get_tree().get_first_node_in_group('card_gui')
	card_gui.aquire_new_card(card)
