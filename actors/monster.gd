extends Sprite2D
class_name Monster

@export var move_distance : int = 16
@export var moves_until_lost_interest : int = 3
@export_range(0, 9, 1) var movement_repeat : int 

@onready var is_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var vision : MonsterVision  = $Vision

@onready var grunt_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

var moves_since_last_seen_player : int = 0
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

func move_monster():
	if not is_on_screen:
		return
	
	var valid_moves : Array[Vector2] = vision.get_valid_movement()
	
	if valid_moves.is_empty():
		return
	
	## first check if the players location is known
	#if players_last_known_position != Vector2(0,0):
		## if known move closer to player
		#move_to = get_vector_direction_to_last_known_location()
	var random_valid_movement = valid_moves.pick_random()
	# pick a random move direction	
	if moves_since_direction_change >= movement_repeat or moves_since_direction_change == 0:
		current_direction = random_valid_movement
		moves_since_direction_change = 0
	
#	execute movement
	var move_tween : Tween = create_tween()
	move_tween.tween_property(self, "position", current_direction * move_distance, 0.2).as_relative()

func grunt() -> void:
	grunt_sfx.play()
