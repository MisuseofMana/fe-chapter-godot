@tool
extends Action
class_name Interaction

enum INTERACTIONS {
	USE,
	OPEN,
	LOCK,
	REST,
	TELEPORT,
	NONE = -1,
}

@export var action_color : Color = Color(0.0, 1.0, 0.0, 1.0)
@export var action : INTERACTIONS = INTERACTIONS.NONE
@export var action_name: String = "Default"

func get_action() -> INTERACTIONS:
	return action
