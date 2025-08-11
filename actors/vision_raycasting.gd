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

func get_vision_data():
	collision_data.clear()
	for vector : Vector2 in raycast_pairs:
		var ray : RayCast2D = raycast_pairs[vector]
		var key = collision_data.get_or_add(vector, {})
		ray.force_raycast_update()
		if ray.is_colliding():
			var collider : Node = ray.get_collider()
			var distance_to_collision : Vector2 = ray.get_collision_point()
			key.get_or_add('detected_node', collider)
			key.get_or_add('is_player', collider.name == 'Hitbox')
			if collider.name == 'Walls':
				if wall_is_adjacent(distance_to_collision):
					key.get_or_add('valid_direction', false)
				else:
					key.get_or_add('valid_direction', true)
			else:
				key.get_or_add('valid_direction', true)
				 
		else:
			key.get_or_add('valid_direction', true)
	return collision_data

func wall_is_adjacent(vector: Vector2):
	# make vector positive	
	var to_local = self.to_local(vector.abs())
	return vector.x >= parent.move_distance or vector.y >= parent.move_distance

func get_valid_movement() -> Array[Vector2]:
	var movements = get_vision_data()
	var only_valid_movements : Array[Vector2] = []
	for dir in movements:
		var vectorDir : Dictionary = movements[dir]
		var is_valid_dir = vectorDir.get('valid_direction', false)
		if is_valid_dir:
			only_valid_movements.push_front(dir)
	return only_valid_movements
	
