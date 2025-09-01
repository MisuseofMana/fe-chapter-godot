extends Sprite2D
class_name Monster

@export var move_distance : int = 16
@export var moves_until_lost_interest : int = 3
@export_range(0, 9, 1) var max_movement_repeat : int 

@onready var is_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var vision : MonsterVision  = $Vision

@onready var grunt_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

var players_last_known_position : Vector2 = Vector2.ZERO
var moves_since_direction_change : int = 0

var current_direction : Vector2 = Vector2.ZERO
		
func get_vector_direction_to_last_known_location() -> Vector2:
	var normalized_vector : Vector2 = (players_last_known_position - global_position).normalized()
	return normalized_vector * move_distance

func check_for_battle_start():
	pass
	#if player_collision_area.has_overlapping_areas():
	#print('start battle')

func ready_for_new_direction() -> bool:
	if current_direction == null:
		return true
	return moves_since_direction_change >= max_movement_repeat

func move_monster():
	if not is_on_screen:
		return
	
	var valid_directions : Array[Vector2] = vision.get_valid_movement_directions()
	
	# pick a random move direction	
	if ready_for_new_direction():
		current_direction = valid_directions.pick_random()
		moves_since_direction_change += 1
	
	if not valid_directions.has(current_direction):
		current_direction = valid_directions.pick_random()
		moves_since_direction_change = 0
		
#	execute movement
	var move_tween : Tween = create_tween()
	move_tween.tween_property(self, "position", current_direction * move_distance, 0.2).as_relative()
	moves_since_direction_change += 1

func grunt() -> void:
	grunt_sfx.play()
