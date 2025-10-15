@tool
extends CanvasLayer
class_name CarouselContainer

@onready var carousel_path = %CarouselPath
@export var card_actions: Array[AbstractCardDetails]
const CAROUSEL_CARD_ACTION = preload("res://resources/carousel_card_action.tscn")
var mod_base : Color = Color(1,1,1)

func _ready():
	for action : AbstractCardDetails in card_actions:
		var new_action_card: CarouselCardAction = CAROUSEL_CARD_ACTION.instantiate()
		new_action_card.card_details = action
		carousel_path.add_child(new_action_card)
		set_path_follow_properties(new_action_card, card_actions.size())

func set_path_follow_properties(card_action: CarouselCardAction, cards_count: int):
	var this_cards_index = card_action.get_index()
	var progress_ratio_incrementer : float = 1 / float(cards_count)
	var current_progress_ratio = progress_ratio_incrementer * this_cards_index
	var z_index_int : int = 99 + (abs(current_progress_ratio - 0.5) * 100)
	
	var center_progress: float = (progress_ratio_incrementer + (progress_ratio_incrementer * float(cards_count - 1))) / float(2)
	
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
		cycle_cards(-1)
	if event.is_action_pressed('cycle_cards_right'):
		cycle_cards(1)

## loops over all the item
func cycle_cards(direction_to_cycle: int):
	var path_index = carousel_path.get_child_count() - 1
	var all_nodes : Array[Node] = []
	for path: PathFollow2D in carousel_path:
		path.get_child(0).reparent()
	
#	if 1, shift end to 

		
func cycle_cards_to_right():
	for cards in carousel_path:
		pass
