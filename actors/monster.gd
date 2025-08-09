extends Sprite2D
class_name Monster

@onready var on_screen_node: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var player_detection_area: Area2D = $PlayerDetectionArea

@onready var grunt_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
 
@onready var ray_north: RayCast2D = $WallDetection/North
@onready var ray_east: RayCast2D = $WallDetection/East
@onready var ray_south: RayCast2D = $WallDetection/South
@onready var ray_west: RayCast2D = $WallDetection/West

@onready var area_north: CollisionShape2D = $PlayerDetectionArea/North
@onready var area_east: CollisionShape2D = $PlayerDetectionArea/East
@onready var area_south: CollisionShape2D = $PlayerDetectionArea/South
@onready var area_west: CollisionShape2D = $PlayerDetectionArea/West

var has_just_seen_player : int = 0

# associates cardinal rays with their corresponding vision collision shapes
func rays_paired_to_vision_areas() -> Dictionary[RayCast2D, CollisionShape2D]: 
	return {
		ray_north: area_north,
		ray_east: area_east,
		ray_south: area_south,
		ray_west: area_west,
	}

# associates cardinal rays with their corresponding vector direction
func vectors_paired_to_rays() -> Dictionary[Vector2, RayCast2D]: 
	return {
		Vector2.UP: ray_north,
		Vector2.RIGHT: ray_east,
		Vector2.DOWN: ray_south,
		Vector2.LEFT: ray_west,
	}

func get_all_valid_movement_vectors() -> Array[Vector2]:
	var availableDirections : Array[Vector2] = []
	var pairs = vectors_paired_to_rays()
	for direction : Vector2 in pairs:
		var directionIsColliding = pairs[direction].is_colliding()
		if not directionIsColliding:
			availableDirections.push_front(direction)
	
	return availableDirections
	
func on_screen() -> bool:
	return on_screen_node.is_on_screen()

func update_active_vision_areas():
	var pairs = rays_paired_to_vision_areas()
	for ray : RayCast2D in pairs:
		if ray.is_colliding():
			pairs[ray].disabled = true
		else:
			pairs[ray].disabled = false

func disable_vision() -> void :
	var all_vision_shapes = [area_north, area_east, area_south, area_west]
	for shape : CollisionShape2D in all_vision_shapes:
		shape.disabled = true

func can_see_player() -> bool:
	if player_detection_area.has_overlapping_areas():
		has_just_seen_player += 1
	else: 
		has_just_seen_player = 0
	return player_detection_area.has_overlapping_areas()

func grunt() -> void:
	if has_just_seen_player == 1:
		grunt_sfx.play()
