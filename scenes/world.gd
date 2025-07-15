@tool
extends Node2D

@export var player_spawn : Marker2D
@export var player_container : PlayerContainer
@export var monster_container : MonsterContainer

func _ready():
	player_container.position = player_spawn.global_position
