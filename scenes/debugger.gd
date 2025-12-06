extends Control
class_name Debugger

@export var debug_enabled : bool = false

@onready var debug_hud: Debugger = $"."
@onready var label: Label = $PanelContainer/HBoxContainer/Label


func _ready():
	if not debug_enabled:
		debug_hud.queue_free()
	EventBus.action_completed.connect(action_completed)
	EventBus.selected_card_changed.connect(selected_card_changed)
	EventBus.interactable_focused.connect(set_focused_interactable)

func action_completed():
	label.text = 'action completed'
	
func selected_card_changed(action: Action):
	label.text = str(action.get_action())

func set_focused_interactable(interactable):
	label.text = str(interactable)
	
