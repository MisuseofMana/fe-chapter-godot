extends Node2D
class_name SceneManager

@export var scene_container: Node2D
@export var animated_transition: CanvasLayer

var new_scene : Node

@export var scene_path_directory: Dictionary[String, String] = {
	"main_menu": "res://scenes/main_menu.tscn",
	"cutscene": "res://scenes/cutscene.tscn",
	"dungeon": "res://scenes/dungeon_manager.tscn",
	"combat": "res://scenes/combat_manager.tscn"
}

var current_scene_int : String = "main_menu"

func _ready():
	preload_new_scene("main_menu")

func preload_new_scene(scene_path: String) -> void:
	new_scene = load(scene_path_directory[scene_path]).instantiate()
	animated_transition.fade_in()

func finalize_scene_swap():
	if not scene_container.get_children().is_empty():
		scene_container.get_child(0).queue_free()
	scene_container.add_child(new_scene)
	animated_transition.fade_out()
	
func _on_child_entered_tree(node: Node):
	if node.has_node('SceneSwapSignal'):
		var swap_node : SceneSwapSignal = node.scene_swap_node
		swap_node.request_scene_change.connect(preload_new_scene)
