extends Control
class_name Debugger

@onready var label = $VBoxContainer/Label
@onready var texture_rect = $VBoxContainer/TextureRect

func _ready():
	EventBus.action_completed.connect(action_completed)
	EventBus.selected_card_changed.connect(selected_card_changed)
	EventBus.card_deselected.connect(clear_texture)

func action_completed():
	print('action completed')
	label.text = 'action completed'
	
func selected_card_changed(action: Action):
	print('active card changed')
	texture_rect.texture = action.texture

func clear_texture():
	texture_rect.texture = null
