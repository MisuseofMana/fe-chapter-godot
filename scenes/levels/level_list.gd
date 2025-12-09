extends Node
class_name LevelList

@export var current_dungeon : int = 1
@export var current_floor : int  = 1

func get_level_filepath() -> Resource:
	return load(str("res://scenes/levels/dungeon_", str(current_dungeon), "/floor_" + str(current_floor) + ".tscn"))
