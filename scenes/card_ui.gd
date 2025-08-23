@tool
extends CanvasLayer
class_name CardGui

@export var anims : AnimationPlayer

@export_category('Cool')
@export_tool_button('Slide Drawer') var track_callable = toggle_drawer

var drawer_visible : bool = false

func _ready() -> void:
	toggle_drawer()

func _input(event: InputEvent) -> void:
	const actions = ['ToggleCards']
	var is_valid_input = actions.has(event.as_text())
	if Input.is_action_just_pressed('ToggleCards'):
		toggle_drawer()
	
func toggle_drawer():
	if drawer_visible:
		anims.play('hide_drawer')
		drawer_visible = false
	else:
		anims.play_backwards('hide_drawer')
		drawer_visible = true
