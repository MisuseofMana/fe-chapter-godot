extends Node2D
class_name GameManager

@onready var active_scene: Node2D = %ActiveScene

var new_scene : Node
var scene_to_remove: Node

signal scene_swap_started
signal scene_swap_ended

func preload_new_scene(scene_path: String):
	new_scene = load(scene_path).instantiate()
	scene_to_remove = active_scene.get_child(0)
	scene_swap_started.emit()

func finalize_scene_swap():
	scene_to_remove.queue_free()
	active_scene.add_child(new_scene)
	scene_swap_ended.emit()
