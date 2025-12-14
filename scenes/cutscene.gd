extends CanvasLayer
class_name Cutscene

@export var scene_swap_node: SceneSwapSignal

func _on_button_pressed():
	scene_swap_node.request_scene_change.emit('dungeon')
