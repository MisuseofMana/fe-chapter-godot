extends Resource
class_name AbstractCardDetails

enum CARD_TYPE {
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

@export var card_type : CARD_TYPE

@export_category('Card Stats')
@export_range(1, 9) var power : int = 1

func reduce_card_power_by_one():
	power -= 1

func get_color():
	match card_type:
		[0, 1]: return 'red'
		[2, 3]: return 'black'
		[4, 5]: return 'orange'
		[6, 7]: return 'blue'
		_: null
		
