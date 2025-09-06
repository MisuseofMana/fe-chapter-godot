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

func interaction_possible(target) -> bool:
	var subject : Node2D = target.get_collider().owner
	if subject is Interactable:
		if subject.can_interact:
			subject.interact_with()
			return true
	return false

func attempt_movement(relative_pos: Vector2, can_move_here: bool = true):
	lock_movement = true
	var origin_pos = position
	var lvl_tween : Tween = create_tween()
	lvl_tween.tween_property(self, "position", position + relative_pos, 0.2)
	if not can_move_here:
		lvl_tween.tween_property(self, "position", origin_pos, 0.2)
	lvl_tween.tween_callback(move_all_monsters)
	
func handle_move_direction_input(ray: RayCast2D):
	var movement_vector : Vector2
	var valid_move : bool = false
	
	var movement_map : Dictionary[RayCast2D, Vector2] = {
		up: Vector2.UP,
		down: Vector2.DOWN,
		left: Vector2.LEFT,
		right: Vector2.RIGHT
	}
	
#	if direction is colliding with something
	if ray.is_colliding():
#		if that collision is an interactable thing
		if interaction_possible(ray):
			return
#		if it isn't interactable bounce away
		else:
			attempt_movement(movement_map[ray] * bounce_distance, false) 
#	if able to move here, move to that location
	else:
		attempt_movement(movement_map[ray] * move_distance, true)

func _input(event: InputEvent) -> void:
	const actions = ['W', 'A', 'S', 'D', 'Space']
		
	var is_valid_input = actions.has(event.as_text())
	if lock_movement or not is_valid_input:
		return
		
	var valid_move : bool = false
	
	if Input.is_action_just_pressed('up'):
		handle_move_direction_input(up)
			
	if Input.is_action_just_pressed('down'):
		handle_move_direction_input(down)
	
	if Input.is_action_just_pressed('left'):
		handle_move_direction_input(left)
		
	if Input.is_action_just_pressed('right'):
		handle_move_direction_input(right)
			
	if Input.is_action_just_pressed('wait'):
		attempt_movement(Vector2.ZERO)
		
