extends Node2D
class_name SpaceSelector

@export var player: PlayerContainer

@onready var squares = $Squares
@onready var cursor = $AnimatedSprite2D
@onready var anims = $AnimationPlayer

const SELECTOR_SQUARE = preload("uid://dk2e101cnxd3i")

var registered_interactables : Array[Interactable] = []
var selected_interactable : Interactable

var cardinal_dir : Array[Vector2] = [
	Vector2.UP,
	Vector2.RIGHT,
	Vector2.DOWN,
	Vector2.LEFT,
]

func _ready():
	EventBus.selected_card_changed.connect(generate_target_squares)
	EventBus.card_deselected.connect(remove_target_squares)
	
func move_cursor(vector: Vector2):
	if EventBus.movement_locked:
		var new_glob_pos : Vector2 = cursor.global_position + (vector * 16)
		var range_acceptance = ((float(squares.get_children().size()) / 4) * 16)
		if new_glob_pos.distance_to(player.global_position) <= range_acceptance:
			var tween = get_tree().create_tween()
			tween.tween_property(cursor, 'global_position', cursor.global_position + (vector * 16), 0.1)
		else:
			anims.play('error')
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('up'):
		move_cursor(Vector2.UP)
			
	if event.is_action_pressed('down'):
		move_cursor(Vector2.DOWN)
	
	if event.is_action_pressed('left'):
		move_cursor(Vector2.LEFT)
		
	if event.is_action_pressed('right'):
		move_cursor(Vector2.RIGHT)
		
func generate_square(multiplier : int, vector_dir : Vector2, action_color : Color):
	var loc : Vector2 = player.global_position
	var square : SelectorSquare = SELECTOR_SQUARE.instantiate()
	squares.add_child(square)
	square.interactable_detected.connect(register_interactable)
	square.self_modulate = action_color
	square.global_position = loc + (vector_dir * 16 * (multiplier))
	
func generate_target_squares(passedAction : Action):
	cursor.global_position = player.global_position
	for n in passedAction.effective_distance:
		var current_multiplier : int = n + 1
		for dir : Vector2 in cardinal_dir:
			generate_square(current_multiplier, dir, passedAction.action_color)
	cursor.show()

func remove_target_squares():
	for child in squares.get_children():
		child.queue_free()
	registered_interactables.clear()
	selected_interactable = null
	cursor.hide()
	
func register_interactable(interactable : Interactable):
	if interactable.action_triggers.has(EventBus.active_action):
		registered_interactables.push_back(interactable)
		cursor.global_position = registered_interactables[0].global_position

func register_selected_interactable(interactable: Interactable):
	if registered_interactables.has(interactable):
		selected_interactable = interactable
