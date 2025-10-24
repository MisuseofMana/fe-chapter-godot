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

@export var action : INTERACTIONS = INTERACTIONS.NONE

func get_sprite_frames() -> SpriteFrames:
	return preload("uid://dhc1wisadhv7e")
	
func get_action() -> INTERACTIONS:
	return action
