extends Node2D
class_name PlayerContainer

var game_data = load("res://resources/game_data.gd")

@onready var player: Sprite2D = $PlayerSprite

@onready var down : RayCast2D = $WallDetection/Down
@onready var right : RayCast2D = $WallDetection/Right
@onready var up : RayCast2D = $WallDetection/Up
@onready var left : RayCast2D = $WallDetection/Left
@onready var wall_detection = $WallDetection

var move_distance : int = 16
var bounce_distance : int = 4

@onready var input_direction_map : Dictionary[RayCast2D, Vector2] = {
	up: Vector2.UP,
	down: Vector2.DOWN,
	left: Vector2.LEFT,
	right: Vector2.RIGHT
}

signal player_just_moved
signal action_attempted_on(interactable : Interactable)
	
func move_all_monsters():
	player_just_moved.emit()

func interaction_possible(target) -> bool:
	var subject : Node2D = target.get_collider().owner
	if subject is Interactable:
		if subject.can_interact:
			subject.interact_with()
			return true
	return false

func attempt_movement(relative_pos : Vector2, can_move_here: bool = true):
	game_data.movement_locked = true
	var origin_pos = position
	var lvl_tween : Tween = create_tween()
	if can_move_here:
		lvl_tween.tween_property(self, "position", position + relative_pos, 0.2)
	if not can_move_here:
		lvl_tween.tween_property(self, "position", position + relative_pos, 0.1)
		lvl_tween.tween_property(self, "position", origin_pos, 0.1)
	lvl_tween.tween_callback(move_all_monsters)

func attempt_action(ray : RayCast2D):
#	handle action pressed 
	if ray.is_colliding():
		var interactable = ray.get_collider().owner
		if interactable is Interactable:
			action_attempted_on.emit(interactable)

func handle_direction_input(ray: RayCast2D):
#	if movement is locked there is an active card 
	if game_data.movement_locked:
		attempt_action(ray)
		return
		
#	if direction is colliding with something
	if ray.is_colliding():
		attempt_movement(input_direction_map[ray] * bounce_distance, false) 
#	if able to move here, move to that location
	else:
		attempt_movement(input_direction_map[ray] * move_distance, true)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed('up'):
		handle_direction_input(up)
			
	if Input.is_action_just_pressed('down'):
		handle_direction_input(down)
	
	if Input.is_action_just_pressed('left'):
		handle_direction_input(left)
		
	if Input.is_action_just_pressed('right'):
		handle_direction_input(right)
			
	if Input.is_action_just_pressed('wait'):
		attempt_movement(Vector2.ZERO)
		
