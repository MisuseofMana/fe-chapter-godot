extends Control
class_name Debugger

@export var debug_enabled : bool = false

@onready var texture_rect = $VBoxContainer/TextureRect
@onready var label: Label = $VBoxContainer/Label
@onready var debugger: Debugger = $"."

func _ready():
	if not debug_enabled:
		debugger.queue_free()
	EventBus.action_completed.connect(action_completed)
	EventBus.selected_card_changed.connect(selected_card_changed)
	EventBus.card_deselected.connect(clear_texture)
	EventBus.adjacent_interactions_registered.connect(set_registered_interactables)

func action_completed():
	label.text = 'action completed'
	
func selected_card_changed(action: Action):
	texture_rect.texture = action.texture

func clear_texture():
	texture_rect.texture = null

func set_registered_interactables(all_interactables):
	label.text = str(all_interactables)
	
