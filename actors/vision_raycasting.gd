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

var last_chosen_movement : Vector2

func get_vision_data() -> Dictionary:
	var vision_dictionary := {}
	
#	loop through vector keys paired to raycasts
	for vector : Vector2 in raycast_pairs:
		var ray : RayCast2D = raycast_pairs[vector]
		ray.force_raycast_update()
		
#		if ray hits something
		if ray.is_colliding():
#			get the absolute vector (positive distance to the collision)
			var collision_point : Vector2 = (ray.get_collision_point() - parent.global_position).abs()
			var sum_of_vector_directions = collision_point.x + collision_point.y
			
#			if collision is further than 8, can move there
			if sum_of_vector_directions > 8:
				vision_dictionary.get_or_add(vector, {'is_valid_direction': true})
#			if collision is 8 or less, can't move there
			elif sum_of_vector_directions <= 8:
				vision_dictionary.get_or_add(vector, {'is_valid_direction': false})
#		if no collision detected, can move here
		else:
			vision_dictionary.get_or_add(vector, {'is_valid_direction': true})
			
#		Should we put whiskey in this coffee?
	print(vision_dictionary) 
	return vision_dictionary 

func check_for_wall_collision(collider_keys):
	print(parent.move_distance)
	print(collider_keys)
	var to_local : Vector2 = Vector2.ZERO
	if collider_keys.is_wall:
		to_local = collider_keys.vector.abs()
	return
	
	# make vector positive
	return to_local.x <= parent.move_distance or to_local.y <= parent.move_distance

func get_a_valid_movement_direction() -> Vector2:
	var allowed_vector_movements : Array[Vector2] = []
	var collisions : Dictionary = get_vision_data()
	for vectorKey : Vector2 in collisions:
		var visionData : Dictionary = collisions[vectorKey]
		if visionData.get('is_valid_direction'):
			allowed_vector_movements.push_front(vectorKey)
	
	var random_movement = allowed_vector_movements.pick_random()
	last_chosen_movement = random_movement
	return random_movement
	
