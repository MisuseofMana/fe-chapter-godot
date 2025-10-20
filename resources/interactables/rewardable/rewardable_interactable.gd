extends Interactable
class_name RewardableInteractable

@export var interaction_reward : Action

enum STATES {
	UNLOOTED,
	LOOTED,
	DESTROYED
}

var state : STATES = STATES.UNLOOTED:
	set(value):
		state = value

func get_state():
	return state

func set_state(newState : STATES):
	state = newState

func handle_interaction(passedAction: Action):
	if action_triggers.has(passedAction):
		pass
