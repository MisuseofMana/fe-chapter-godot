@tool
extends Node2D
class_name CardCarousel

@export var card_actions: Array[Action]
@export var cycle_speed_base: float

@onready var carousel_path = %CarouselPath
@onready var cycle_timer: Timer = %CycleTimer
@onready var anims = %AnimationPlayer
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

const CAROUSEL_CARD_ACTION = preload("res://cards/carousel_card_action.tscn")
var mod_base : Color = Color(1,1,1)

var cycling_locked: bool = true
var focused_card : CarouselCardAction

var cycle_speed : float

signal confirm_button_changed(state : bool)

func _ready():
	cycle_speed = cycle_speed_base
	for card_action : Action in card_actions:
		add_action_to_carousel(card_action)
	recalculate_card_properties('initalize')

func get_progress_ratio_incrementer() -> float:
	return 1 / float(card_actions.size())

func add_action_to_carousel(passedAction: Action):
	var new_action_card: CarouselCardAction = CAROUSEL_CARD_ACTION.instantiate()
	new_action_card.action = passedAction
	carousel_path.add_child(new_action_card)

func recalculate_card_properties(behavior : String) -> void:
	cycling_locked = true
	var all_paths = carousel_path.get_children()
	
	for path : CarouselCardAction in all_paths:
		var index_in_tree: int = path.get_index()
		
		if index_in_tree == 0:
			focused_card = path
		
		var progress_ratio : float
		
		if behavior == 'initalize':
			progress_ratio = get_progress_ratio_incrementer() * float(index_in_tree)
		if behavior == 'increase':
			progress_ratio = snapped(path.progress_ratio, get_progress_ratio_incrementer()) + get_progress_ratio_incrementer()
		if behavior == 'decrease':
			progress_ratio = snapped(path.progress_ratio, get_progress_ratio_incrementer()) - get_progress_ratio_incrementer()
		
		var float_progress : float = abs(float(progress_ratio) - int(progress_ratio))
		var percentage_from_center = abs(0.5 - float_progress) * 2
		var modulate_percentage = 0.95 - (0.95 * percentage_from_center)
		
		var tween : Tween = get_tree().create_tween()
		tween.set_parallel()
		tween.set_ease(Tween.EASE_OUT_IN)
		tween.tween_property(path, "progress_ratio", progress_ratio, cycle_speed)
		tween.tween_property(path, "modulate", mod_base.darkened(modulate_percentage), cycle_speed)
		tween.tween_property(path, "z_index", percentage_from_center * 10, cycle_speed)
		
#		when the last tween is finished, unlock the movement
		if path.get_index() == all_paths.size() - 1:
			tween.tween_callback(
				func (): cycling_locked = false
			).set_delay(cycle_speed)
			cycle_speed = clamp(cycle_speed - 0.05, 0.1, cycle_speed_base)
			cycle_timer.start()

var movement_inputs : Array[StringName] = ['up', 'down', 'left', 'right']

func _input(event):
	if cycling_locked or not visible_on_screen_notifier_2d.is_on_screen():
		return
	
	if carousel_path.get_children().size() > 1:
		if event.is_action_pressed('cycle_cards_left', true):
			cycle_cards_left()
		if event.is_action_pressed('cycle_cards_right', true):
			cycle_cards_right()
			
	if event.is_action_pressed('confirm_action'):
		handle_card_animation(true)
	if event.is_action_pressed('cancel_action'):
		if focused_card.action.card_is_active:
			handle_card_animation(false)

func cycle_cards_right():
	handle_card_animation(false)
	var first : CarouselCardAction = carousel_path.get_child(0)
	carousel_path.move_child(first, -1)
	recalculate_card_properties('decrease')
		
func cycle_cards_left():
	handle_card_animation(false)
	var last : CarouselCardAction = carousel_path.get_child(-1)
	carousel_path.move_child(last, 0)
	recalculate_card_properties('increase')
	
func _on_cycle_timer_timeout() -> void:
	cycle_speed = cycle_speed_base	
	
func handle_card_animation(being_activated: bool):
	if being_activated:
		focused_card.raise_card()
		confirm_button_changed.emit(true)
	else:
		focused_card.lower_card()
		confirm_button_changed.emit(false)
		
func show_carousel():
	anims.play('toggle_carousel')
	cycling_locked = false
	
func hide_carousel():
	anims.play_backwards("toggle_carousel")
	handle_card_animation(false)
	cycling_locked = true
