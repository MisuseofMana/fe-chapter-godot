extends Node2D
class_name GameController

@onready var level_handler: LevelHandler = %LevelHandler
@onready var hud: CanvasLayer = %HUD
@onready var player: Player = %Player

@export var save_file: Resource

signal next_level_preloaded

var current_level_depth : int = 0
var current_world : int = 0
var preloaded_level: Level

func _ready():
	hud.show()
	player.show()

func prepare_level_swap(level_path: String):
	print(level_path)
	preloaded_level = load(level_path).instantiate()
	next_level_preloaded.emit()
	# should pack the previous level in the level progress to the save file
	# should determine if the level is higher or lower in the level order
	# to correctly move the player to the entrance or exit
	pass
