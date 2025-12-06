extends Node2D
class_name LevelHandler

@export var level_container: Node2D
@export var animated_transition : AnimatedTransition

var is_descending: bool = true
var preloaded_level: Level

signal monster_turn_over

func _ready():
	SceneSwitcher.entered_transition_zone.connect(preload_next_level)
	SceneSwitcher.level_finished_loading.connect(finish_level_swap)
	
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

# triggered by staricases interaction
func preload_next_level(new_level: PackedScene, descending: bool) -> void:
	preloaded_level = new_level.instantiate()
	is_descending = descending

# triggered when the scene transition animation finished fading in
func finish_level_swap():
	get_current_level().queue_free()
	level_container.add_child.call_deferred(preloaded_level)
	SceneSwitcher.level_swap_completed.emit(preloaded_level.get_spawn_point_vector(is_descending))
	
	
