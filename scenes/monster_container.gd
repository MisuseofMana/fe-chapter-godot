extends Node2D
class_name MonsterContainer

var move_distance : int = 32
var lock_movement : bool = false

signal monsters_finished_moving

func move_monster(whichMonster: Monster):
	var move_to = pick_movement_direction(whichMonster)
	var move_tween : Tween = create_tween()
	move_tween.tween_property(self, "position", move_to , 0.2).as_relative()

func handle_monster_movement():
	var all_monsters = get_children()
	for monster : Monster in all_monsters:
		if monster.on_screen():
			move_monster(monster)
	monsters_finished_moving.emit()

func pick_movement_direction(monster: Monster) -> Vector2:
	var wall_collisions = monster.get_cardinal_collisions()
	var valid_vectors : Array[Vector2] = []
	var vectorDict = {
		'N': Vector2.UP,
		'E': Vector2.RIGHT,
		'S': Vector2.DOWN,
		'W': Vector2.LEFT,
	}
	for coll in wall_collisions:
		if not wall_collisions[coll]:
			valid_vectors.append(vectorDict[coll])
	
	valid_vectors.shuffle()
	
	return valid_vectors[0] * move_distance
	
