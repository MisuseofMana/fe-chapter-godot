extends Node2D
class_name CarouselContainer

var carousels : Array[CardCarousel] = []

func _ready():
	for child : CardCarousel in get_children():
		carousels.push_back(child)
	for carousel in carousels:
		if carousel.get_index() == 0:
			carousel.show_carousel()
			carousel.cycling_locked = false

func _input(event):
	if event.is_action_pressed('cycle_action_type'):
		show_next_carousel()
		EventBus.card_deselected.emit()

func show_next_carousel():
	var first : CardCarousel =	carousels.pop_front()
	first.hide_carousel()
	carousels.push_back(first)
	carousels[0].show_carousel()
