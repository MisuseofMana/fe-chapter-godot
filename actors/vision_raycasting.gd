extends Node2D
class_name MonsterVision

@onready var north = $North
@onready var east = $East
@onready var south = $South
@onready var west = $West

@onready var raycast_pairs = {
	Vector2.UP: north,
	Vector2.RIGHT: east,
	Vector2.DOWN: south,
	Vector2.LEFT: west,
}

@export var parent : Monster

var collision_data : Dictionary[Vector2, Dictionary] = {}

func _ready():
	update_vision_data.call_deferred()

func update_vision_data():
#	Clear out collision data
	collision_data.clear()
	
#	loop through vector keys paired to raycasts
	for vector : Vector2 in raycast_pairs:
		var ray : RayCast2D = raycast_pairs[vector]
		ray.force_raycast_update()
		
#		if ray hits something
		if ray.is_colliding():
			var collision_point : Vector2 = ray.get_collision_point() - parent.global_position
			print(collision_point)
			print(ray.get_collision_normal())
			
#			Should we put whiskey in this coffee?

	return collision_data

func check_for_wall_collision(collider_keys):
	print(parent.move_distance)
	print(collider_keys)
	var to_local : Vector2 = Vector2.ZERO
	if collider_keys.is_wall:
		to_local = collider_keys.vector.abs()
	return
	
	# make vector positive
	return to_local.x <= parent.move_distance or to_local.y <= parent.move_distance

func get_valid_movement() -> Array[Vector2]:
	var allowed_vector_movements : Array[Vector2] = [ Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
	for vectorKey : Vector2 in collision_data:
		var vectorDir : Dictionary = collision_data[vectorKey]
		var is_allowed_movement_vector = vectorDir.get('valid_direction')
		if not is_allowed_movement_vector:
			
	return only_valid_movements
	
