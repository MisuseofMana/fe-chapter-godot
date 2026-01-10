extends Node2D
class_name SceneManager

@export var scene_container: Node2D
@export var animated_transition: CanvasLayer

var new_scene : Node

func preload_new_scene(scene_path: String) -> void:
	new_scene = load(scene_path).instantiate()
	#new_scene = load(scene_path_directory[scene_path]).instantiate()
	animated_transition.fade_in()

func finalize_scene_swap():
	if not scene_container.get_children().is_empty():
		scene_container.get_child(0).queue_free()
	scene_container.add_child(new_scene)
	animated_transition.fade_out()
	
func _on_new_scene_entered_scene_container(node: Node):
	if node is GameLayer:
		assert(node.has_method("swap_scene"), 'Provided node must have a swap_scene method.')
		node.started_scene_swap_to.connect(preload_new_scene)
