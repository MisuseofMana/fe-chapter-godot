extends Node2D
class_name Interactable

@export var inital_interaction_sound : AudioStreamPlayer2D
@export var secondary_interaction_sound : AudioStreamPlayer2D
@export var action : Action
@export var selector_indicator : Sprite2D
@export var can_become_walkable : bool = false
@export var oneshot_interaction : bool = false

@onready var interaction_area = $InteractionArea
@onready var interaction_icon_bg: Sprite2D = $InteractionIconBG
@onready var interaction_icon: Sprite2D = $InteractionIconBG/InteractionIcon
@onready var interaction_sprite = $InteractionSprite
@onready var reward_container = $RewardContainer

@export var interactable_card_reward : Action = null

const CARD_COLLECTIBLE = preload("res://cards/card_collectible.tscn")

var can_interact : bool = false
var hint_icon_visible : bool = false

var has_been_interacted : bool = false

var reward_target_node : CollectibleCard

enum STATES {
	DEFAULT,
	HINTED,
	PREPARED,
	OPEN,
	CLOSED,
	USED,
}

var current_state : STATES = STATES.DEFAULT

func _ready():
	if interactable_card_reward:
		var card_reward_node = CARD_COLLECTIBLE.instantiate()
		card_reward_node.card_details = interactable_card_reward
		reward_container.add_child(card_reward_node)
	interaction_icon.texture = action.texture

func attempt_to_claim_collectable():
	if reward_container.get_child_count() == 0:
		return
	var reward : CollectibleCard = reward_container.get_child(0)
	if reward and reward.has_method('reveal_self'):
		reward.reveal_self()

func initial_interaction_handler():
	attempt_to_claim_collectable()
	if can_become_walkable:
		interaction_area.set_collision_layer_value(1, false)
	interaction_sprite.frame = 1
	inital_interaction_sound.play()
	has_been_interacted = true
	
func secondary_interaction_handler():
	if can_become_walkable:
		interaction_area.set_collision_layer_value(1, true)
	interaction_sprite.frame = 0
	secondary_interaction_sound.play()
	has_been_interacted = false

func attempt_interaction():
	if not selector_indicator.visible:
		return
	get_tree().call_group('player_cards', 'use_card')
	if not has_been_interacted:
		initial_interaction_handler()
	elif has_been_interacted:
		secondary_interaction_handler()

func update_hint(action : Action):
	if action == action:
		show_interaction_icon()
	else:
		hide_interaction_icon()

func hide_interaction_icon():
	interaction_icon_bg.hide()
	
func show_interaction_icon():
	interaction_icon_bg.show()

func show_selector_indicator():
	selector_indicator.show()
	
func hide_selector_indicator():
	selector_indicator.hide()
