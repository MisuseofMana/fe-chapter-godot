extends CanvasLayer
class_name MainMenu

@onready var load_game_button = %LoadGameButton

@export var scene_swap_node: SceneSwapSignal

func _ready():
	if has_save_file():
		load_game_button.disabled = true

func start_new_game():
	scene_swap_node.swap_scene("new_game")
	
func start_tutorial():
	scene_swap_node.swap_scene("tutorial")
	
func has_save_file() -> bool:
	return false
