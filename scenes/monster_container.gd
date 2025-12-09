extends Node2D
class_name MonsterContainer

signal monster_turn_over
	
func handle_monster_movement():
	var all_monsters = get_children()
	for monster : Monster in all_monsters:
		monster.move_monster()
	monster_turn_over.emit()
