extends Node2D
class_name GameController

@onready var level_handler: LevelHandler = %LevelHandler
@onready var hud: CanvasLayer = %HUD
@onready var player: Player = %Player

func _ready():
	hud.show()
	player.show()
