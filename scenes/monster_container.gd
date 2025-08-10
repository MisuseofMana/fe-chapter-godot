extends Node2D
class_name MonsterContainer

var move_distance : int = 32
var lock_movement : bool = false

signal monsters_finished_moving
	
func handle_monster_movement():
	var all_monsters = get_children()
	for monster : Monster in all_monsters:
		if monster.on_screen():
			monster.check_for_visible_player.call_deferred()
	monsters_finished_moving.emit()

func pick_random_movement_direction(monster: Monster) -> Vector2:
	var valid_movement : Array[Vector2] = monster.get_all_valid_movement_vectors()
	
	valid_movement.shuffle()
	
	if valid_movement.is_empty():
		return Vector2(0,0)
	
	return valid_movement[0] * move_distance
	
