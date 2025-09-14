extends Node2D
class_name Interactable

@export var inital_interaction_sound : AudioStreamPlayer2D
@export var secondary_interaction_sound : AudioStreamPlayer2D
@export var interactable_name : AbstractCardDetails.CARD_TYPE
@export var selector_indicator : Sprite2D
@export var can_become_walkable : bool = false
@export var oneshot_interaction : bool = false

@onready var interaction_area = $InteractionArea
@onready var interaction_icon = $InteractionIcon
@onready var interaction_sprite = $InteractionSprite
@onready var reward_container = $RewardContainer

@export var interactable_card_reward : AbstractCardDetails = null

const CARD_COLLECTIBLE = preload("res://cards/card_collectible.tscn")

var can_interact : bool = false
var has_been_interacted : bool = false
var has_claimed_collectable : bool = false

var reward_target_node : CollectibleCard

signal interaction_succeded(interaction_type : AbstractCardDetails.CARD_TYPE)

func _ready():
	if interactable_card_reward:
		var card_reward_node = CARD_COLLECTIBLE.instantiate()
		card_reward_node.card_details = interactable_card_reward
		reward_container.add_child(card_reward_node)
	interaction_icon.frame = interactable_name

func attempt_to_claim_collectable():
	if not has_claimed_collectable && interactable_card_reward != null:
		has_claimed_collectable = true
		var reward : CollectibleCard = reward_container.get_child(0)
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
	if not has_been_interacted and can_interact:
		initial_interaction_handler()
	elif has_been_interacted and can_interact:
		secondary_interaction_handler()
	elif not can_interact:
#		should play an error sound
		pass
	GameManager.ACTION_ATTEMPTED_FOR.emit(interactable_name)

func matches_selected_card(card_type: AbstractCardDetails.CARD_TYPE) -> bool:
	return interactable_name == card_type

func handle_interaction_icon_visibility(card_type : AbstractCardDetails.CARD_TYPE = AbstractCardDetails.CARD_TYPE['NONE']):
	if matches_selected_card(card_type):
		interaction_icon.show()
	else:
		interaction_icon.hide()

func handle_within_reach_status(card_type : AbstractCardDetails.CARD_TYPE):
	if matches_selected_card(card_type):
		selector_indicator.show()
		can_interact = true
	else:
		selector_indicator.hide()
		can_interact = false
	
func hide_details(interaction_type : AbstractCardDetails.CARD_TYPE):
	if interaction_type == interactable_name:
		if selector_indicator.visible:
			selector_indicator.hide()
		if interaction_icon.visible:
			interaction_icon.hide()
			
