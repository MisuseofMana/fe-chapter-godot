extends Node2D
class_name InteractableController

@export var player_node : PlayerContainer

var active_interaction_type : AbstractCardDetails.CARD_TYPE = AbstractCardDetails.CARD_TYPE['NONE']

func get_interactables_by_type(card_type : AbstractCardDetails.CARD_TYPE) -> Array[Interactable]:
	var aggregator : Array[Interactable] = []
	for interactable : Interactable in get_children():
		if interactable.interactable_name == card_type:
			aggregator.push_front(interactable)
	return aggregator
	
func handle_interaction_icon_display(card_type : AbstractCardDetails.CARD_TYPE = AbstractCardDetails.CARD_TYPE['NONE']):
	hide_interaction_icons_by_type()
	active_interaction_type = card_type
	for interactable : Interactable in get_interactables_by_type(card_type):
		interactable.show_interaction_icon()

func hide_interaction_icons_by_type():
	if active_interaction_type != AbstractCardDetails.CARD_TYPE['NONE']:
		for interactable : Interactable in get_interactables_by_type(active_interaction_type):
			interactable.hide_interaction_icon()

func handle_toggle_selector_visibility():
	pass
	
func handle_action_occured():
	pass

func disable_all_indicators(card_type : AbstractCardDetails.CARD_TYPE):
	for interactable : Interactable in get_interactables_by_type(card_type):
		interactable.hide_interactable_hints()
	
func _on_player_action_attempted_on(interactable : Interactable):
	if interactable.can_interact:
		interactable.attempt_interaction()
