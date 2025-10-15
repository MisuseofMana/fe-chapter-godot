@tool
extends Resource
class_name AbstractCardDetails

@export var card_type : GameActions.ACTIONS = GameActions.ACTIONS.NONE
@export_range(0, 100, 1) var actions_to_cooldown : int = 0
@export_range(-1, 10) var usage_limit: int = -1

var texture_lookup: Dictionary[GameActions.ACTIONS, CompressedTexture2D] = {
	GameActions.ACTIONS.HEART: preload("res://assets/cards/suits/heart.png"),
	GameActions.ACTIONS.DIAMOND: preload("res://assets/cards/suits/diamond.png"),
	GameActions.ACTIONS.CLUB: preload("res://assets/cards/suits/club.png"),
	GameActions.ACTIONS.SPADE: preload("res://assets/cards/suits/spade.png"),
	GameActions.ACTIONS.CROSS: preload("res://assets/cards/suits/wheel.png"),
	GameActions.ACTIONS.WAVE: preload("res://assets/cards/suits/wave.png"),
	GameActions.ACTIONS.STAR: preload("res://assets/cards/suits/star.png"),
	GameActions.ACTIONS.DROP: preload("res://assets/cards/suits/drop.png"),
	GameActions.ACTIONS.RANGED_ATTACK: preload("res://assets/cards/suits/arrow.png"),
	GameActions.ACTIONS.MELEE_ATTACK: preload("res://assets/cards/suits/melee.png"),
	GameActions.ACTIONS.BURST: preload("res://assets/cards/suits/burst.png"),
	GameActions.ACTIONS.SWIRL: preload("res://assets/cards/suits/swirl.png"),
	GameActions.ACTIONS.OPEN: preload("res://assets/cards/suits/key.png"),
	GameActions.ACTIONS.LOCK: preload("res://assets/cards/suits/lock.png"),
	GameActions.ACTIONS.REST: preload("res://assets/cards/suits/rest.png"),
	GameActions.ACTIONS.COMPASS: preload("res://assets/cards/suits/compass.png"),
	GameActions.ACTIONS.NONE: preload("res://assets/cards/suits/placeholder.png"),
}

func get_texture() -> CompressedTexture2D:
	return texture_lookup[card_type]
