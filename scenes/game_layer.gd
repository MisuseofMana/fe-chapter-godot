extends CanvasLayer
class_name GameLayer

signal started_scene_swap_to(scene_path: String)

func swap_scene(scene_path: String) -> void:
	started_scene_swap_to.emit(scene_path)
