extends CanvasLayer
class_name MainMenu

@onready var load_game_button = %LoadGameButton

signal scene_change_requested(scene_path: String)

func _ready():
	if has_save_file():
		load_game_button.disabled = true

func start_new_game():
	scene_change_requested.emit("res://scenes/dungeon_manager.tscn")
	
func start_tutorial():
	scene_change_requested.emit("res://scenes/levels/dungeon_0_tutorial/tutorial_level.tscn")
	
func has_save_file() -> bool:
	return false
