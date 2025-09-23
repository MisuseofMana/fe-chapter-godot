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

signal new_action_primed()
signal action_cleared

@export var movement_locked : bool = false

var active_card : AbstractCard = null

func prime_action(card : AbstractCard):
	active_card = card

func unprime_action():
	active_card = null
	
func get_active_action():
	return active_card.card_details.card_type
	
