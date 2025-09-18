extends Resource
class_name GameData

enum ACTIONS {
	HEART,
	DIAMOND,
	CLUB,
	SPADE,
	CROSS,
	WAVE,
	STAR,
	DROP,
	RANGED_ATTACK,
	MELEE_ATTACK,
	BURST,
	SWIRL,
	OPEN,
	LOCK,
	REST,
	COMPASS,
	NONE = -1,
}

@export var movement_locked : bool = false
@export var active_cards : Array[ACTIONS]
