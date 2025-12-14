extends Node
class_name SaveAndLoad

var current_save_slot: int = 0

func update_save_slot(save_slot_number: int):
	current_save_slot = save_slot_number

func save_game():
	var file = FileAccess.open("res://game_saving/save_files/file_" + str(current_save_slot), FileAccess.WRITE)
	print(file)
	
func load_game():
	pass
