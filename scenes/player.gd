extends Node2D
class_name AbstractPlayer

@export var deck : Array[AbstractCardDetails]

func _ready():
	deck.shuffle()
	var hand = deck.slice(0,3)
