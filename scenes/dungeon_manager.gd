extends GameLayer
class_name DungeonManager

@onready var level_handler: LevelHandler = %LevelHandler
@onready var hud: CanvasLayer = %HUD
@onready var player: Player = %Player

var input_locked : bool = false

func lock_input():
	input_locked = true

func unlock_input():
	input_locked = false

func is_input_locked() -> bool:
	return input_locked

func _ready():
	hud.show()
	player.show()
