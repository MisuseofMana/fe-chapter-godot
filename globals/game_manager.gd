extends Node

var active_card : AbstractCardDetails.CARD_TYPE = AbstractCardDetails.CARD_TYPE.NONE

func activate_card_action(card_type : AbstractCardDetails.CARD_TYPE) -> void:
	print(card_type)
	active_card = card_type
	activate_neighbor_squares()
	
func activate_neighbor_squares():
	for ray : RayCast2D in get_tree().get_nodes_in_group('player_rays'):
		if ray.is_colliding():
			var subject : Node2D = ray.get_collider().owner
			if subject is Interactable:
				if subject.interactable_name == active_card:
					subject.activate_interactability()
		
func deactivate_card_action():
	active_card = AbstractCardDetails.CARD_TYPE.NONE
	for interactable : Interactable in get_tree().get_nodes_in_group('interactable_item'):
		interactable.deactivate_interactability()
