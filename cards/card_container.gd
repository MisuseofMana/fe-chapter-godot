extends Node2D
class_name CardContainer

@export_enum('monster_group', 'player_group') var group_to_assign : String
@export var deck : Array[AbstractCardDetails]
@export var slots : Node2D

const CARD_BASE = preload("res://cards/abstract_card/card_base.tscn")

func _ready():
	var current_position : int = 1
	for card in deck:
		var baseCard : AbstractCard = CARD_BASE.instantiate()
		baseCard.card = card
		baseCard.card_position = current_position
		baseCard.add_to_group(group_to_assign)
		add_child(baseCard)
		baseCard.global_position = slots.get_children()[current_position - 1].global_position
		current_position += 1

func unselect_all_cards():
	for card : AbstractCard in get_children():
		card.unselect_card()
