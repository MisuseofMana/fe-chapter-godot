extends Resource
class_name AbstractCardDetails

@export var card_type : GameData.ACTIONS
@export var texture : CompressedTexture2D

@export_category('Card Stats')
@export_range(1, 9) var power : int = 1
