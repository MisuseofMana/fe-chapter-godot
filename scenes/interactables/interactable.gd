extends Node2D
class_name Interactable

@export var inital_interaction_sound : AudioStreamPlayer2D
@export var secondary_interaction_sound : AudioStreamPlayer2D
@export var interactable_name : AbstractCardDetails.CARD_TYPE
@export var selector_indicator : Sprite2D

var can_interact : bool = false

func activate_interactability():
	can_interact = true
	selector_indicator.visible = true

func deactivate_interactability():
	can_interact = false
	selector_indicator.visible = false
	
