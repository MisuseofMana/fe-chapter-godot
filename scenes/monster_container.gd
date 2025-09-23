extends Node2D
class_name MonsterContainer

var game_data = load("res://resources/game_data.tres")

var move_distance : int = 32
var lock_movement : bool = false

signal monsters_finished_moving
	
func handle_monster_movement():
	var all_monsters = get_children()
	for monster : Monster in all_monsters:
		monster.move_monster()
	game_data.movement_locked = false
