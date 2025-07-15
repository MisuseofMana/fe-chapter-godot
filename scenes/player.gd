extends Node2D
class_name PlayerContainer

@onready var player: Sprite2D = $PlayerSprite

@onready var down: RayCast2D = $Area2D/Down
@onready var right: RayCast2D = $Area2D/Right
@onready var up: RayCast2D = $Area2D/Up
@onready var left: RayCast2D = $Area2D/Left

var move_distance : int = 16
var bounce_distance : int = 4
var lock_movement : bool = false

signal player_just_moved

func unlock_movement():
	lock_movement = false
	
func move_all_monsters():
	player_just_moved.emit()

func invalid_movement(relative_pos: Vector2):
	lock_movement = true
	var origin_pos = position
	var lvl_tween : Tween = create_tween()
	lvl_tween.tween_property(self, "position", position + relative_pos, 0.1)
	lvl_tween.tween_property(self, "position", origin_pos, 0.1)
	lvl_tween.tween_callback(move_all_monsters)

func valid_movement(relative_pos: Vector2):
	lock_movement = true
	var lvl_tween : Tween = create_tween()
	lvl_tween.tween_property(self, "position", position + relative_pos, 0.2)
	lvl_tween.tween_callback(move_all_monsters)
	
func _input(event: InputEvent) -> void:
	const actions = ['W', 'A', 'S', 'D']
	var is_valid_input = actions.has(event.as_text())
	if lock_movement or not is_valid_input:
		return
		
	var movement_vector : Vector2
	var valid_move : bool = false
	
	if Input.is_action_just_pressed('up'):
		if up.is_colliding():
			movement_vector = Vector2(0, -bounce_distance) 
		else:
			valid_move = true
			movement_vector = Vector2(0, -move_distance)
			
	if Input.is_action_just_pressed('down'):
		if down.is_colliding():
			movement_vector = Vector2(0, bounce_distance) 
		else:
			valid_move = true
			movement_vector = Vector2(0, move_distance)
	
	if Input.is_action_just_pressed('left'):
		if left.is_colliding():
			movement_vector = Vector2(-bounce_distance, 0) 
		else: 
			movement_vector = Vector2(-move_distance, 0)
			valid_move = true
		
	if Input.is_action_just_pressed('right'):
		if right.is_colliding():
			movement_vector = Vector2(bounce_distance, 0) 
		else: 
			movement_vector = Vector2(move_distance, 0)
			valid_move = true
		
	if valid_move:
		valid_movement(movement_vector)
	else:
		invalid_movement(movement_vector)
