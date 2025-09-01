extends Node2D
class_name PlayerContainer

@onready var player: Sprite2D = $PlayerSprite

@onready var down : RayCast2D = $WallDetection/Down
@onready var right : RayCast2D = $WallDetection/Right
@onready var up : RayCast2D = $WallDetection/Up
@onready var left : RayCast2D = $WallDetection/Left
@onready var wall_detection = $WallDetection

var move_distance : int = 16
var bounce_distance : int = 4
var lock_movement : bool = false

signal player_just_moved

func unlock_movement():
	lock_movement = false
	
func move_all_monsters():
	player_just_moved.emit()

func wait():
	lock_movement = true
	move_all_monsters()

func attempt_movement(relative_pos: Vector2, can_move_here: bool = true):
	lock_movement = true
	var origin_pos = position
	var lvl_tween : Tween = create_tween()
	lvl_tween.tween_property(self, "position", position + relative_pos, 0.2)
	if not can_move_here:
		lvl_tween.tween_property(self, "position", origin_pos, 0.2)
	lvl_tween.tween_callback(move_all_monsters)
	
func _input(event: InputEvent) -> void:
	const actions = ['W', 'A', 'S', 'D', 'Space']
		
	var is_valid_input = actions.has(event.as_text())
	if lock_movement or not is_valid_input:
		return
		
	if GameManager.active_card != AbstractCardDetails.CARD_TYPE.NONE:
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
			movement_vector = Vector2(0, move_distance)
			valid_move = true
	
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
			
	if Input.is_action_just_pressed('wait'):
		movement_vector = Vector2(0, 0)
		valid_move = true
		
	attempt_movement(movement_vector, valid_move)
