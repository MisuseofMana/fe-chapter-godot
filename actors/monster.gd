extends Sprite2D
class_name Monster

@onready var on_screen_node: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var player_detection_area: Area2D = $PlayerDetectionArea

@onready var grunt_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var south: RayCast2D = $PlayerDetectionArea/South
@onready var east: RayCast2D = $PlayerDetectionArea/East
@onready var north: RayCast2D = $PlayerDetectionArea/North
@onready var west: RayCast2D = $PlayerDetectionArea/West

var has_just_seen_player : int = 0

func on_screen() -> bool:
	return on_screen_node.is_on_screen()

func can_see_player() -> bool:
	if player_detection_area.has_overlapping_areas():
		has_just_seen_player += 1
	else: 
		has_just_seen_player = 0
	return player_detection_area.has_overlapping_areas()

func grunt() -> void:
	if has_just_seen_player == 1:
		grunt_sfx.play()

func get_cardinal_collisions() -> Dictionary[String, bool]:
	return {
		'N': north.is_colliding(),
		'E': east.is_colliding(),
		'S': south.is_colliding(),
		'W': west.is_colliding()
	}
