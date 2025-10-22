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
@export var interaction_sprites : Dictionary[STATES, CompressedTexture2D]
@export var interaction_sounds : Dictionary[STATES, AudioStreamRandomizer]
@export var interaction_reward : Action

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var sfx: AudioStreamPlayer2D = $SoundEffect
@onready var interaction_icon: Sprite2D = $InteractionHintBG/InteractionIcon
@onready var hint_circle: Sprite2D = $HintCircle

var current_state : STATES = STATES.DEFAULT

func _ready():
	EventBus.selected_card_changed.connect(show_icon_hint)
	EventBus.card_deselected.connect(hide_icon)

func show_icon_hint(primed_action: Action):
	if action_triggers.has(primed_action):
		interaction_icon.texture = primed_action.texture
		hint_circle.show()

func hide_icon():
	hint_circle.hide()

func handle_interaction(attempted_action : Action):
	if action_triggers.has(attempted_action):
		current_state = action_triggers[attempted_action]
		match(current_state):
			STATES.LOOTED:
				loot_interactable()
			STATES.INTERACTED:
				trigger_interaction()
			STATES.DESTROYED:
				trigger_destruction()
				
func trigger_interaction():
	sprite.texture = interaction_sprites[STATES.INTERACTED]
	sfx.stream = interaction_sounds[STATES.INTERACTED]
	sfx.play()
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
	for action : Action in action_triggers:
		if action_triggers[action] == passed_state:
			action_triggers.erase(action)
		
