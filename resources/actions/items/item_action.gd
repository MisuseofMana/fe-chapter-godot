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

@export var action: ITEMS = ITEMS.NONE

func get_sprite_frames() -> SpriteFrames:
	return preload("uid://dxgyu6jt4sewr")

func get_action() -> ITEMS:
	return action
