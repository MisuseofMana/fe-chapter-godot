extends Node2D
class_name SpaceSelector

const SELECTION_SQUARE = preload("uid://cnj0udvbxyrh3")

@export var player: PlayerContainer

var cardinal_dir : Array[Vector2] = [
	Vector2.UP,
	Vector2.LEFT,
	Vector2.DOWN,
	Vector2.RIGHT
]

func _ready():
	EventBus.selected_card_changed.connect(generate_target_squares)
	EventBus.card_deselected.connect(remove_target_squares)
	
func generate_target_squares(passedAction : Action):
	var loc : Vector2 = player.global_position
	for n in passedAction.effective_distance:
		for dir : Vector2 in cardinal_dir:
			var square = Sprite2D.new()
			square.texture = preload("uid://cnj0udvbxyrh3")
			add_child(square)
			square.self_modulate = passedAction.action_color
			square.global_position = loc + (dir * 16 * (n + 1))

func remove_target_squares():
	for child in get_children():
		child.queue_free()
	
	
