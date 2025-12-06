extends Sprite2D
class_name LevelTransition

@export var level : PackedScene
@export var is_decending : bool = false
@export var spawn_point: Marker2D
@export var marker_only: bool = false
@onready var area_2d: Area2D = $Area2D

func _ready():
	if marker_only:
		area_2d.queue_free()

func _on_player_entered(_area: Area2D) -> void:
	if level:
		SceneSwitcher.entered_transition_zone.emit(level, is_decending)
