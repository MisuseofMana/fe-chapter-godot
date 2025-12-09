extends Node
#EVENT BUS AUTOLOAD

var active_action : Action
var movement_locked : bool = false

# Game Logic Signals for UI Interactions and Game Events
@warning_ignore("unused_signal")
signal selected_card_changed(action: Action)

@warning_ignore("unused_signal")
signal card_deselected

@warning_ignore("unused_signal")
signal action_completed()

@warning_ignore("unused_signal")
signal interactable_focused(interactable : Node)

@warning_ignore("unused_signal")
signal new_card_aquired(action_details : Action)

func _on_selected_card_changed(action: Action) -> void:
	active_action = action
	get_tree().call_group('interactable_item', 'update_hint', action)
	
func _on_card_deselected() -> void:
	active_action = null
	get_tree().call_group('interactable_item', 'hide_selector_indicator')
	
