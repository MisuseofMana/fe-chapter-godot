extends Control
class_name Cutscene

@export var filepath: String

func _on_button_pressed():
	get_tree().change_scene_to_file(filepath)
