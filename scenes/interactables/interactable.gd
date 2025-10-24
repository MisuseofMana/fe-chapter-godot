@tool
extends Node2D
class_name Interactable

enum STATES {
	DEFAULT,
	LOOTED,
	INTERACTED,
	DESTROYED,
}

signal new_loot_collected(passed_loot : Action)

@export var action_triggers : Dictionary[Action, STATES]
@export var actions_to_swap_to : Dictionary[Action, STATES]
@export var interaction_sprites : Dictionary[STATES, CompressedTexture2D]
@export var hint_sprites : Dictionary[STATES, CompressedTexture2D]
@export var interaction_reward : Action
@export var interaction_sounds : Dictionary[STATES, AudioStreamRandomizer]
@export var can_become_walkable : bool = false

var is_walkable : bool = false

@onready var sprite: Sprite2D = %Sprite
@onready var sfx: AudioStreamPlayer2D = %SoundEffect
@onready var interaction_icon: Sprite2D = %InteractionIcon
@onready var hint_circle: Sprite2D = %HintCircle
@onready var collision = $MovementArea/MovementCollider

var current_state : STATES = STATES.DEFAULT

func _ready():
	EventBus.selected_card_changed.connect(show_green_hint_outline)
	EventBus.card_deselected.connect(disable_hint_sprite)

func show_green_hint_outline(primed_action: Action):
	if action_triggers.has(primed_action):
		sprite.texture = hint_sprites[current_state]
func disable_hint_sprite():
	sprite.texture = interaction_sprites[current_state]

func handle_interaction(attempted_action : Action):
	if action_triggers.has(attempted_action):
		current_state = action_triggers[attempted_action]
		match(current_state):
			STATES.DEFAULT:
				trigger_reset()
			STATES.LOOTED:
				loot_interactable()
			STATES.INTERACTED:
				trigger_interaction()
			STATES.DESTROYED:
				trigger_destruction()

func trigger_reset():
	sprite.texture = interaction_sprites[STATES.DEFAULT]
	sfx.stream = interaction_sounds[STATES.DEFAULT]
	sfx.play()
	if can_become_walkable:
		is_walkable = false
		swap_valid_actions_to()
		return
	exhaust_action_by_state(STATES.DEFAULT)

func trigger_interaction():
	sprite.texture = interaction_sprites[STATES.INTERACTED]
	sfx.stream = interaction_sounds[STATES.INTERACTED]
	sfx.play()
	if can_become_walkable:
		is_walkable = true
		swap_valid_actions_to()
		return
	exhaust_action_by_state(STATES.INTERACTED)

func trigger_destruction():
	sprite.texture = interaction_sprites[STATES.DESTROYED]
	sfx.stream = interaction_sounds[STATES.DESTROYED]
	sfx.play()
	exhaust_action_by_state(STATES.DESTROYED)

func loot_interactable():
	sprite.texture = interaction_sprites[STATES.LOOTED]
	new_loot_collected.emit(interaction_reward)
	exhaust_action_by_state(STATES.LOOTED)

func exhaust_action_by_state(passed_state: STATES):
	for action : Action in action_triggers.keys():
		if action_triggers[action] == passed_state:
			action_triggers.erase(action)
	EventBus.action_completed.emit()
	
func swap_valid_actions_to():
	var stored_actions = action_triggers.duplicate()
	action_triggers = actions_to_swap_to.duplicate()
	actions_to_swap_to = stored_actions
	EventBus.action_completed.emit()
