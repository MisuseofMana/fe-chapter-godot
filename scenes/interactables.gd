extends Node2D
class_name InteractableController

var adjacent_interactions : Array[Interactable] = []

func _ready():
	EventBus.adjacent_interactions_registered.connect(update_registered_interactables)
	#EventBus.selected_card_changed.connect(update_primed_interactables)
	
func update_registered_interactables(interactables: Array[Interactable]):
	adjacent_interactions = interactables

#func update_primed_interactables(passedAction: Action):
	#for interactable: Interactable in adjacent_interactions:
		#interactable.show_icon_hint(passedAction)
