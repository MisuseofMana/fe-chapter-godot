extends Node2D
class_name Interactable

@export var inital_interaction_sound : AudioStreamPlayer2D
@export var secondary_interaction_sound : AudioStreamPlayer2D
@export var interactable_name : AbstractCardDetails.CARD_TYPE
@export var selector_indicator : Sprite2D
@export var can_become_walkable : bool = false

@onready var interaction_area = $InteractionArea

@onready var interaction_icon = $InteractionIcon
@onready var interaction_sprite = $InteractionSprite

var can_interact : bool = false
var has_been_interacted : bool = false

func _ready():
	interaction_icon.texture = AbstractCardDetails.card_icon[interactable_name]

func activate_interactability():
	can_interact = true
	selector_indicator.visible = true

func deactivate_interactability():
	can_interact = false
	selector_indicator.visible = false

func interact_with():
	if has_been_interacted:
		if can_become_walkable:
			interaction_area.set_collision_layer_value(1, true)
		interaction_sprite.frame = 0
		secondary_interaction_sound.play()
		has_been_interacted = false
	elif not has_been_interacted :
		if can_become_walkable:
			interaction_area.set_collision_layer_value(1, false)
		interaction_sprite.frame = 1
		inital_interaction_sound.play()
		has_been_interacted = true

func show_icon():
	interaction_icon.show()

func hide_icon():
	interaction_icon.hide()
