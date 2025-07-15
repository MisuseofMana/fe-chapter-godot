extends Sprite2D
class_name Monster

@onready var on_screen_node: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

@onready var south: RayCast2D = $PlayerDetectionArea/South
@onready var east: RayCast2D = $PlayerDetectionArea/East
@onready var north: RayCast2D = $PlayerDetectionArea/North
@onready var west: RayCast2D = $PlayerDetectionArea/West

func on_screen() -> bool:
	return on_screen_node.is_on_screen()

func can_see_player() -> bool:
#	TODO - logic for player detection
	return false

func get_cardinal_collisions() -> Dictionary[String, bool]:
	return {
		'N': north.is_colliding(),
		'E': east.is_colliding(),
		'S': south.is_colliding(),
		'W': west.is_colliding()
	}
