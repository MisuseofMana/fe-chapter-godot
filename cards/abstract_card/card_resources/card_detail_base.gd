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
}

@export var card_name : StringName = ''
@export var card_type : CARD_TYPE
@export var card_texture : Texture2D
@export var suit_texture : Texture2D
@export var card_bar_texture : Texture2D

@export var destroy_effects : Array[Resource]
@export var card_cost : int = 0

@export_category('Card Stats')
@export_range(0, 6) var movement_value = 0
@export_range(0, 6) var power_value : int = 0

@export_multiline var card_description : String = ''
