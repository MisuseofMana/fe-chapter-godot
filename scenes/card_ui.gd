@tool
extends CanvasLayer
class_name CardGui

@export var anims : AnimationPlayer

@onready var ui_slide_sound = $UISlideSound

@export_category('Tools')
@export_tool_button('Slide Drawer') var track_callable = toggle_drawer

var drawer_visible : bool = false

func _ready() -> void:
	pass
	#toggle_drawer()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed('ToggleCards'):
		toggle_drawer()
	
func toggle_drawer():
	ui_slide_sound.play()
	if drawer_visible:
		anims.play('hide_drawer')
		drawer_visible = false
	else:
		anims.play_backwards('hide_drawer')
		drawer_visible = true
