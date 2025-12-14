extends Node2D

@onready var current_scene = %CurrentScene

signal fade_requested

func swap_to_new_scene(scene_path: String):
	var new_scene = load(scene_path).instantiate()
	var scene_to_delete = current_scene.get_child(0)
	fade_requested.emit()
	
