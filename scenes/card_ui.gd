@tool
extends Node2D
class_name CardGui

@export var anims : AnimationPlayer

@export_category('Cool')
@export_tool_button('Slide Drawer') var track_callable = show_gui

func show_gui():
	anims.play('slide')
