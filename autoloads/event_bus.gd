extends Node
#EVENT BUS AUTOLOAD

# Game Logic Signals for UI Interactions and Game Events
signal selected_card_changed(action: Action)
signal card_deselected
signal adjacent_interactions_registered(registered_interactions : Array[Interactable])
signal new_card_aquired(action_details : Action)

func _on_selected_card_changed(action: Action) -> void:
	get_tree().call_group('interactable_item', 'update_hint', action)
	
func _on_card_deselected() -> void:
	get_tree().call_group('interactable_item', 'hide_selector_indicator')
	
