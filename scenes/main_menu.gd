extends CanvasLayer
class_name MainMenu

@onready var load_game_button = %LoadGameButton

func _ready():
	if has_save_file():
		load_game_button.disabled = true

func start_new_game():
	get_tree().change_scene_to_file()
	
func start_tutorial():
	get_tree().change_scene_to_file("uid://bf6l6gw486uwb")
	SceneSwitcher.entered_transition_zone.emit("uid://dqhqbwlalhfrr", true)
	
func has_save_file() -> bool:
	return false
