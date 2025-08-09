extends Node2D
class_name MonsterContainer

var move_distance : int = 32
var lock_movement : bool = false

signal monsters_finished_moving

func move_monster(monster: Monster):
	var can_see_player : bool = monster.can_see_player()
	var move_to : Vector2
	if can_see_player:
		move_to = get_vector_direction_to_player(monster)
		monster.grunt()
	else:
		move_to = pick_random_movement_direction(monster)
	
	monster.disable_vision()
	var move_tween : Tween = create_tween()
	move_tween.finished.connect(monster.update_active_vision_areas)
	move_tween.tween_property(self, "position", move_to , 0.2).as_relative()
	
func handle_monster_movement():
	var all_monsters = get_children()
	for monster : Monster in all_monsters:
		if monster.on_screen():
			move_monster(monster)
	monsters_finished_moving.emit()

func get_vector_direction_to_player(monster: Monster) -> Vector2:
	var player_global_direction = get_tree().get_first_node_in_group('player_node').global_position
	var monster_global_pos = monster.global_position
	var normalized_vector : Vector2 = (player_global_direction - monster_global_pos).normalized()
	return normalized_vector * move_distance

func pick_random_movement_direction(monster: Monster) -> Vector2:
	var valid_movement : Array[Vector2] = monster.get_all_valid_movement_vectors()
	
	valid_movement.shuffle()
	
	if valid_movement.is_empty():
		return Vector2(0,0)
	
	return valid_movement[0] * move_distance
	
