extends PathFollow2D
class_name CarouselCardAction

var action: Action
@onready var action_icon = %ActionIcon
@onready var card_selection_indicator = %CardSelectionIndicator
@onready var anims = %AnimationPlayer
@onready var label: Label = $Node2D/Label
@onready var timer: Timer = $Timer

func _ready():
	action_icon.texture = action.texture
	label.text = action.action_name
	EventBus.action_completed.connect(lower_card)
	
func use_card():
	lower_card()
	
func raise_card():
	if not action.card_is_active:
		anims.play('raise_card')
		action.card_is_active = true
		EventBus.movement_locked = true
	
func lower_card():
	if action.card_is_active:
		anims.play_backwards('raise_card')
		action.card_is_active = false
		EventBus.movement_locked = false

func flash_hint_label():
	anims.play('action_name_display')
	timer.start()

func _on_timer_timeout() -> void:
	anims.play_backwards('action_name_display')
