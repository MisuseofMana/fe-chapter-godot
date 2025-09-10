extends Node2D
class_name LevelExit

@export var level_to_load = PackedScene

func _on_area_2d_area_entered(area):
	print('player standing on exit')
	transition_to_new_level()
	
func transition_to_new_level():
#	transition fade in
#	remove old level
#	add new level
# 	when the new level enters it should teleport the player to the spawn location
#  
	pass
	
