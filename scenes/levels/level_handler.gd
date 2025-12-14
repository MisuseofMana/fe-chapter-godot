extends Node2D
class_name LevelHandler

@export var level_container: Node2D
@export var animated_transition : AnimatedTransition

var is_descending: bool = true
var preloaded_level: Level

signal monster_turn_over
	
func handle_monster_movement():
	var all_monsters = get_monsters()
	if all_monsters.is_empty():
		monster_turn_over.emit()	
	for monster : Monster in all_monsters:
		monster.move_monster()
	monster_turn_over.emit()
	
func get_monsters():
	var level = get_current_level()
	return level.get_all_monsters()

func get_current_level():
	return level_container.get_child(0)

func register_level_transitions():
	pass
#	should access the new levels transition zones and connect their signals to this script

# triggered when the scene transition animation finished fading in
func finish_level_swap():
	get_current_level().queue_free()
	level_container.add_child.call_deferred(preloaded_level)
	SceneSwitcher.level_swap_completed.emit(preloaded_level.get_spawn_point_vector(is_descending))
	
	
