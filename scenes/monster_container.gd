extends Node2D
class_name MonsterContainer

var move_distance : int = 32
var lock_movement : bool = false

signal monsters_finished_moving
	
func handle_monster_movement():
	var all_monsters = get_children()
	for monster : Monster in all_monsters:
		monster.move_monster()
	GameManager.movement_locked = false
