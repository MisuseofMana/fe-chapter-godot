extends Node
#EVENT BUS AUTOLOAD

# Game Logic Signals for UI Interactions and Game Events
@warning_ignore("unused_signal")
signal selected_card_changed(action: Action)

@warning_ignore("unused_signal")
signal card_deselected

@warning_ignore("unused_signal")
signal adjacent_interactions_registered(registered_interactions : Array[Interactable])

@warning_ignore("unused_signal")
signal new_card_aquired(action_details : Action)

func _on_selected_card_changed(action: Action) -> void:
	get_tree().call_group('interactable_item', 'update_hint', action)
	
func _on_card_deselected() -> void:
	get_tree().call_group('interactable_item', 'hide_selector_indicator')
	
