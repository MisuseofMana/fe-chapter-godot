extends Node2D
class_name SelectorSquare

var valid_interactables : Array[Interactable] = []

signal interactable_detected(interactable: Interactable)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_interaction_detection_area_area_entered(area):
	if area.owner is Interactable:
		interactable_detected.emit(area.owner)
