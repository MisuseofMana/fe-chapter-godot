extends Node2D
class_name InteractableController

func disable_all_indicators():
	for interactable : Interactable in get_children():
		interactable.hide_details(interactable.interactable_name)
		
	
