@tool
extends CanvasLayer
class_name CarouselContainer

@onready var carousel_path = %CarouselPath
@export var card_actions: Array[AbstractCardDetails]
@export var cycle_speed: float
const CAROUSEL_CARD_ACTION = preload("res://resources/carousel_card_action.tscn")
var mod_base : Color = Color(1,1,1)

var cycling_locked: bool = false

func _ready():
	for action : AbstractCardDetails in card_actions:
		var new_action_card: CarouselCardAction = CAROUSEL_CARD_ACTION.instantiate()
		new_action_card.card_details = action
		carousel_path.add_child(new_action_card)
		set_path_follow_properties(new_action_card)

func get_progress_ratio_incrementer() -> float:
	return 1 / float(card_actions.size())

func set_path_follow_properties(card_action: CarouselCardAction):
	var this_cards_index = card_action.get_index()
	var progress_ratio_incrementer : float = get_progress_ratio_incrementer()
	var current_progress_ratio = progress_ratio_incrementer * this_cards_index
	var z_index_int : int = 99 + (abs(current_progress_ratio - 0.5) * 100)
	
	var center_progress: float = (progress_ratio_incrementer + (progress_ratio_incrementer * float(card_actions.size() - 1))) / float(2)
	var modulate_percentage : float = 0.8 - abs(center_progress - current_progress_ratio)
	
	if this_cards_index == 0:
		modulate_percentage = 0
	
	card_action.progress_ratio = current_progress_ratio
	card_action.z_index = z_index_int
	card_action.modulate = mod_base.darkened(modulate_percentage)

# when [Q] is pressed, cycle right to left
# when [E] is pressed, cycle left to right
func _input(event):
	if event.is_action_pressed('cycle_cards_left'):
		cycle_cards_left()
	if event.is_action_pressed('cycle_cards_right'):
		cycle_cards_right()

func get_list_of_properties(array_of_nodes : Array[Node]) -> Array[Dictionary]:
	var properties : Array[Dictionary]
	for node : PathFollow2D in array_of_nodes:
		properties.push_back({
			'progress_ratio': node.progress_ratio,
			'z_index': node.z_index,
			'modulate': node.modulate
		})
	return properties

func cycle_cards_left():
	var all_path_nodes : Array[Node] = carousel_path.get_children()
	var properties = get_list_of_properties(all_path_nodes)
	var first_property = properties.pop_front()
	properties.push_back(first_property)
	tween_paths(all_path_nodes, properties, 1)
		
func cycle_cards_right():
	var all_path_nodes : Array[Node] = carousel_path.get_children()
	var properties = get_list_of_properties(all_path_nodes)
	var first_property = properties.pop_back()
	properties.push_front(first_property)
	tween_paths(all_path_nodes, properties, -1)

func unlock_cycling(): 
	cycling_locked = false

func tween_paths(old_array : Array[Node], new_props: Array[Dictionary], progress_addition: int):
	for i in old_array.size():
		var node_to_modify = old_array[i]
		var node_properties = new_props[i]
		
		var tween : Tween = get_tree().create_tween()
		tween.set_parallel()
		tween.set_ease(Tween.EASE_OUT_IN)
		tween.tween_property(node_to_modify, "progress_ratio", node_to_modify.progress_ratio + (get_progress_ratio_incrementer() * progress_addition), cycle_speed)
		tween.tween_property(node_to_modify, "modulate", node_properties['modulate'], cycle_speed)
		tween.tween_property(node_to_modify, "z_index", node_properties['z_index'], cycle_speed)
