extends Interactable
class_name Teleporter

@export var interaction_sound : AudioStreamPlayer2D
@export var teleport_destination : Node

func _ready():
	interaction_icon.frame = action

func interaction_handler():
	interaction_sound.play()
	var player: PlayerContainer = get_tree().get_first_node_in_group("player_node")
	if player:
		player.teleport_to(teleport_destination.global_position)

func attempt_interaction():
	if not selector_indicator.visible:
		return
	get_tree().call_group('player_cards', 'use_card')
	interaction_handler()

func update_hint(passedAction : GameActions.ACTIONS):
	if action == passedAction:
		show_interaction_icon()
	else:
		hide_interaction_icon()

func hide_interaction_icon():
	interaction_icon_bg.hide()
	
func show_interaction_icon():
	interaction_icon_bg.show()

func show_selector_indicatorshow_selector_indicator():
	selector_indicator.show()
	
func hide_selector_indicator():
	selector_indicator.hide()
