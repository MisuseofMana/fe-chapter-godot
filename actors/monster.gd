extends Sprite2D
class_name Monster

@export var move_distance : int = 16
@export var moves_until_lost_interest : int = 3

@onready var on_screen_node: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

@onready var grunt_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var north = $WallDetection/North
@onready var east = $WallDetection/East
@onready var south = $WallDetection/South
@onready var west = $WallDetection/West

@onready var north_eyes = $Vision/NorthEyes
@onready var east_eyes = $Vision/EastEyes
@onready var south_eyes = $Vision/SouthEyes
@onready var west_eyes = $Vision/WestEyes

var moves_since_last_seen_player : int = 0
var players_last_known_position : Vector2 = Vector2(0,0)
var tracking_player : bool = false

# associates cardinal wall detection with their corresponding vector direction
func vectors_paired_to_wall_detection() -> Dictionary[Vector2, RayCast2D]: 
	return {
		Vector2.UP: north,
		Vector2.RIGHT: east,
		Vector2.DOWN: south,
		Vector2.LEFT: west,
	}
	
func vectors_paired_to_vision() -> Dictionary[Vector2, RayCast2D]: 
	return {
		Vector2.UP: north_eyes,
		Vector2.RIGHT: east_eyes,
		Vector2.DOWN: south_eyes,
		Vector2.LEFT: west_eyes,
	}

func get_all_valid_movement_vectors() -> Array[Vector2]:
	var availableDirections : Array[Vector2] = []
	var wall_pairs = vectors_paired_to_wall_detection()
	for direction : Vector2 in wall_pairs:
		var directionIsColliding = wall_pairs[direction].is_colliding()
		if not directionIsColliding:
			availableDirections.push_front(direction)
	return availableDirections
	
func on_screen() -> bool:
	return on_screen_node.is_on_screen()
		
func get_vector_direction_to_last_known_location() -> Vector2:
	var normalized_vector : Vector2 = (players_last_known_position - global_position).normalized()
	return normalized_vector * move_distance

func check_for_battle_start():
	pass
	#if player_collision_area.has_overlapping_areas():
		#print('start battle')

func move_monster():
#	 starting variables for use later
	var move_to : Vector2
	var valid_moves = get_all_valid_movement_vectors()
	
#	if there are valid moves
	if valid_moves.size() > 0:
#		first check if the players location is known
		if players_last_known_position != Vector2(0,0):
#			if known move closer to player
			move_to = get_vector_direction_to_last_known_location()
#		if not, pick a random direction to move
		else:
			valid_moves.shuffle()
			move_to = valid_moves[0] * move_distance
#	execute movement
	var move_tween : Tween = create_tween()
	move_tween.tween_property(self, "position", move_to, 0.2).as_relative()

func check_for_visible_player():
	var vision_rays = vectors_paired_to_vision()
	for ray : Vector2 in vision_rays:
		if vision_rays[ray].is_colliding():
			print('can see player')
			players_last_known_position = vision_rays[ray].get_collider().global_position
			moves_since_last_seen_player = 0
			move_monster()
			return
	if moves_since_last_seen_player < moves_until_lost_interest:
		print('pursuing player')
		moves_since_last_seen_player += 1
		move_monster()
		return
	else: 
		print('lost interest')
		players_last_known_position = Vector2(0,0)
		move_monster()

func grunt() -> void:
	grunt_sfx.play()
