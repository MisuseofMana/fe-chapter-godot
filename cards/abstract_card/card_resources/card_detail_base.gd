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
}

@export var card_type : CARD_TYPE
@export var suit_texture : Texture2D

@export_category('Card Stats')
@export_range(0, 9) var power : int = 0

func get_color():
	match card_type:
		[0, 1]: return 'red'
		[2, 3]: return 'black'
		[4, 5]: return 'orange'
		[6, 7]: return 'blue'
		_: null
		
