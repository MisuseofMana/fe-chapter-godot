extends Node
class_name SceneSwapSignal

signal request_scene_change(scene_name: String)

func swap_scene(scene_name: String) -> void:
	request_scene_change.emit(scene_name)
