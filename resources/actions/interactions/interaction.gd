@tool
extends Action
class_name Interaction

enum INTERACTIONS {
	OPEN,
	LOCK,
	REST,
	TELEPORT,
	NONE = -1,
}

@export var action : INTERACTIONS = INTERACTIONS.NONE

func get_action() -> INTERACTIONS:
	return action
