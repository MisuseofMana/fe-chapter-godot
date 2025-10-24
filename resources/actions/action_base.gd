@abstract
@tool
extends Resource
class_name Action

func get_action(): pass

@export var texture : CompressedTexture2D = preload("uid://ibkxqi0a103r")
@export_range(0, 100, 1) var actions_to_cooldown : int = 0
@export_range(-1, 10) var usage_limit: int = -1
@export var effective_distance : int = 1

var card_is_active : bool = false:
	set(new):
		card_is_active = new
		if new == false:
			EventBus.card_deselected.emit()
		if new == true:
			EventBus.selected_card_changed.emit(self)
