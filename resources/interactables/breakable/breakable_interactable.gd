extends Interactable
class_name BreakableInteractable

enum STATES {
	INTACT,
	BROKEN
}

var state : STATES = STATES.INTACT:
	set(value):
		state = value
		handle_interaction()

func get_state():
	return state

func set_state(newState : STATES):
	state = newState

func handle_interaction():
	if 
