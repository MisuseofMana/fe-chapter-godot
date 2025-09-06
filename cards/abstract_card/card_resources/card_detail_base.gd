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
	MOVE,
	RANGED_ATTACK,
	MELEE_ATTACK,
	HEAL,
	DRAW,
	DEFEND,
	OPEN,
	NONE = -1,
}

static var card_icon : Array[Resource] = [
	load("res://assets/cards/suits/heart.png"),
	load("res://assets/cards/suits/diamond.png"),
	load("res://assets/cards/suits/club.png"),
	load("res://assets/cards/suits/spade.png"),
	load("res://assets/cards/suits/cross.png"),
	load("res://assets/cards/suits/wave.png"),
	load("res://assets/cards/suits/star.png"),
	load("res://assets/cards/suits/drop.png"),
	load("res://assets/cards/suits/move.png"),
	load("res://assets/cards/suits/ranged_attack.png"),
	load("res://assets/cards/suits/melee_attack.png"),
	load("res://assets/cards/suits/heart.png"),
	load("res://assets/cards/suits/draw.png"),
	load("res://assets/cards/suits/defense.png"),
	load("res://assets/cards/suits/open.png")
]

@export var card_type : CARD_TYPE

@export_category('Card Stats')
@export_range(0, 9) var power : int = 0

func get_card_suit():
	return card_icon[card_type]

func get_color():
	match card_type:
		[0, 1]: return 'red'
		[2, 3]: return 'black'
		[4, 5]: return 'orange'
		[6, 7]: return 'blue'
		_: null
		
