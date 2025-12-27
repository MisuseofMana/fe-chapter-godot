extends Node
class_name SaveAndLoad

# responsible for saving and loading games

var current_save_slot: int = 0
var current_save_file: Resource

func update_save_slot(save_slot_number: int):
	current_save_slot = save_slot_number

func save_game(_data_to_save):
	var saved_game:SavedGame = SavedGame.new()
#	set all values based on current level
	ResourceSaver.save(saved_game, "user://savegame_" + str(current_save_slot) + ".tres")
	
func get_load_game() -> SavedGame:
	return load("user://savegame_" + str(current_save_slot) + ".tres") as SavedGame
