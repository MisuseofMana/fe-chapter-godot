extends Node2D
class_name Level

@export var entrance : LevelTransition
@export var exit : LevelTransition
@export var monster_container: Node2D
@export var interactable_container: Node2D

func get_spawn_point_vector(is_decending: bool) -> Vector2:
	if is_decending:
		return entrance.spawn_point.global_position
	else:
		return exit.spawn_point.global_position

func get_all_monsters():
	return monster_container.get_children()	
