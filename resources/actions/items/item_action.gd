@tool
extends Action
class_name ItemAction

enum ITEMS {
	HUMAN_DOLL,
	GOBLIN_DOLL,
	CROWN,
	COMPASS,
	NONE = -1
}

@export var action_color : Color = Color(0.863, 0.863, 1.0, 1.0)
@export var action: ITEMS = ITEMS.NONE

func get_action() -> ITEMS:
	return action
