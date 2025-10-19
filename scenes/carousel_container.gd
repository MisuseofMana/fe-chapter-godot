extends CanvasLayer
class_name CarouselContainer

var carousels : Array[CardCarousel] = []

func _ready():
	for carousel : CardCarousel in get_children():
		carousels.push_back(carousel)
	carousels[0].show_carousel()

func _input(event):
	if event.is_action_pressed('cycle_action_type'):
		show_next_carousel()

func show_next_carousel():
	var first : CardCarousel =	carousels.pop_front()
	first.hide_carousel()
	carousels.push_back(first)
	carousels[0].show_carousel()
