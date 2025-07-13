extends Node2D
class_name CardContainer

@export_enum('monster_group', 'player_group') var group_to_assign : String
@export var deck : Array[AbstractCardDetails]

const CARD_BASE = preload("res://cards/abstract_card/card_base.tscn")

func _ready():
	for card in deck:
		var baseCard = CARD_BASE.instantiate()
		baseCard.card = card
		add_child(baseCard)
	for card in get_children():
		card.add_to_group(group_to_assign)
		
