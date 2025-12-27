extends Node2D
class_name SpaceSelector

@export var player: Player
@export var dungeon_manager: DungeonManager

@onready var squares = $Squares
@onready var cursor = $AnimatedSprite2D

const SELECTOR_SQUARE = preload("uid://dk2e101cnxd3i")

var registered_interactables : Array[Interactable] = []
var selected_interactable : Interactable
var cursor_animating : bool = false 
var acceptable_positions : Array[Vector2] = []

var cardinal_dir : Array[Vector2] = [
	Vector2.UP,
	Vector2.RIGHT,
	Vector2.DOWN,
	Vector2.LEFT,
]

func _ready():
	cursor.hide()
	EventBus.selected_card_changed.connect(generate_target_squares)
	EventBus.card_deselected.connect(remove_target_squares)

func update_cursor_status():
	cursor_animating = not cursor_animating

func move_cursor(vector: Vector2):
	if dungeon_manager.input_locked and not cursor_animating:
		var new_glob_pos : Vector2 = cursor.global_position + (vector * 16)
		var tween = get_tree().create_tween()
		update_cursor_status()
		if acceptable_positions.has(new_glob_pos):
			tween.tween_property(cursor, 'global_position', cursor.global_position + (vector * 16), 0.1)
		else:
			var previous_cursor_location : Vector2 = cursor.global_position
			tween.tween_property(cursor, 'global_position', cursor.global_position + (vector * 2), 0.01)
			tween.tween_property(cursor, 'self_modulate', Color(0.951, 0.0, 0.0, 1), 0.04)
			tween.tween_property(cursor, 'self_modulate', Color(1.0, 1.0, 1.0, 1.0), 0.04)
			tween.tween_property(cursor, 'global_position', previous_cursor_location, 0.01)
		tween.tween_callback(update_cursor_status)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('up'):
		move_cursor(Vector2.UP)
			
	if event.is_action_pressed('down'):
		move_cursor(Vector2.DOWN)
	
	if event.is_action_pressed('left'):
		move_cursor(Vector2.LEFT)
		
	if event.is_action_pressed('right'):
		move_cursor(Vector2.RIGHT)
	
	if event.is_action_pressed('confirm_action'):
		if selected_interactable:
			selected_interactable.handle_interaction(EventBus.active_action)
		
		
func generate_square(multiplier : int, vector_dir : Vector2, action_color : Color):
	var loc : Vector2 = player.global_position
	var square : SelectorSquare = SELECTOR_SQUARE.instantiate()
	squares.add_child(square)
	square.interactable_detected.connect(register_interactable)
	square.modulate = action_color
	var square_center : Vector2 = loc + (vector_dir * 16 * (multiplier))
	square.global_position = square_center
	acceptable_positions.push_front(square_center)
	
func generate_target_squares(passedAction : Action):
	if passedAction.effective_distance == 0:
		generate_square(0, Vector2.ZERO, passedAction.action_color)
	cursor.global_position = player.global_position
	acceptable_positions.push_front(player.global_position)
	for n in passedAction.effective_distance:
		var current_multiplier : int = n + 1
		for dir : Vector2 in cardinal_dir:
			generate_square(current_multiplier, dir, passedAction.action_color)
	cursor.show()
	
func remove_target_squares():
	for child in squares.get_children():
		child.queue_free()
	registered_interactables.clear()
	acceptable_positions.clear()
	selected_interactable = null
	cursor.hide()
	
func register_interactable(interactable : Interactable):
	if interactable.action_triggers.has(EventBus.active_action):
		cursor.hide()
		registered_interactables.push_back(interactable)
		#cursor.global_position = registered_interactables[0].global_position
		cursor.show()

func register_selected_interactable(area: Area2D):
	if registered_interactables.has(area.owner):
		selected_interactable = area.owner

func unregister_selected_interactable(area: Area2D):
	if selected_interactable == area.owner:
		selected_interactable = null
