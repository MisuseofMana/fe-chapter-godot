extends Node2D
class_name Player

@onready var player: Sprite2D = $PlayerSprite
@onready var down : RayCast2D = $WallDetection/Down
@onready var right : RayCast2D = $WallDetection/Right
@onready var up : RayCast2D = $WallDetection/Up
@onready var left : RayCast2D = $WallDetection/Left
@onready var wall_detection = $WallDetection
@onready var teleport_particles = %TeleportParticles
@onready var transition_detection: CollisionShape2D = $OverlapDetection/CollisionShape2D

var move_distance : int = 16
var bounce_distance : int = 4

@onready var input_direction_map : Dictionary[RayCast2D, Vector2] = {
	up: Vector2.UP,
	down: Vector2.DOWN,
	left: Vector2.LEFT,
	right: Vector2.RIGHT
}

signal players_turn_over

func _ready():
	SceneSwitcher.entered_transition_zone.connect(lock_movement.unbind(2))
	SceneSwitcher.level_swap_completed.connect(unlock_movement.unbind(1))
	SceneSwitcher.level_swap_completed.connect(teleport_to)
	
func move_all_monsters():
	players_turn_over.emit()

func unlock_movement():
	EventBus.movement_locked = false
	
func lock_movement():
	EventBus.movement_locked = true

func attempt_movement(relative_pos : Vector2, can_move_here: bool = true):
	EventBus.movement_locked = true
	var origin_pos = position
	var lvl_tween : Tween = create_tween()
	if can_move_here:
		lvl_tween.tween_property(self, "position", position + relative_pos, 0.2)
	if not can_move_here:
		lvl_tween.tween_property(self, "position", position + relative_pos, 0.1)
		lvl_tween.tween_property(self, "position", origin_pos, 0.1)
	lvl_tween.tween_callback(move_all_monsters)

func handle_direction_input(ray: RayCast2D):
	if EventBus.movement_locked:
		return
		
#	if direction is colliding with something
	if ray.is_colliding():
		var collision_owner = ray.get_collider().owner
		if collision_owner is Interactable:
			if collision_owner.is_walkable:
				attempt_movement(input_direction_map[ray] * move_distance, true)
				return		
		attempt_movement(input_direction_map[ray] * bounce_distance, false) 
#	if able to move here, move to that location
	else:
		attempt_movement(input_direction_map[ray] * move_distance, true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('up'):
		handle_direction_input(up)
			
	if event.is_action_pressed('down'):
		handle_direction_input(down)
	
	if event.is_action_pressed('left'):
		handle_direction_input(left)
		
	if event.is_action_pressed('right'):
		handle_direction_input(right)
			
	if event.is_action_pressed('wait'):
		attempt_movement(Vector2.ZERO)
		
func teleport_to(global_pos : Vector2):
	lock_movement()
	teleport_particles.emitting = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", global_pos, 0.3)
	tween.tween_callback(func (): unlock_movement())
