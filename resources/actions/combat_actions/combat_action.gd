@tool
extends Action
class_name CombatAction

enum COMBAT_ACTIONS {
	HEAL,
	RANGED_ATTACK,
	MELEE_ATTACK,
	ICE_BOLT,
	FIREBALL,
	WAIT,
	NONE = -1,
}

@export var action: COMBAT_ACTIONS = COMBAT_ACTIONS.NONE

func get_sprite_frames() -> SpriteFrames:
	return preload("uid://bwty5cui12jqy")

func get_action() -> COMBAT_ACTIONS:
	return action
