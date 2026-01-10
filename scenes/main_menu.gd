extends GameLayer
class_name MainMenu

#@onready var load_game_button = %LoadGameButton

#func _ready():
	#if has_save_file():
		#load_game_button.disabled = true

func start_new_game():
	swap_scene("res://scenes/new_game.tscn")
	
func start_tutorial():
	swap_scene("res://scenes/tutorial.tscn")
	
func go_to_options():
	swap_scene("res://scenes/options.tscn")
	
func has_save_file() -> bool:
	return false
