@tool
extends Resource
class_name AbstractCardDetails

@export var card_category: GameActions.ACTION_CATEGORY = GameActions.ACTION_CATEGORY.NONE:
	set(value):
		card_category = value
		notify_property_list_changed() # Important for updating the Inspector
			
@export var card_type: Variant = null

@export_range(0, 100, 1) var actions_to_cooldown : int = 0
@export_range(-1, 10) var usage_limit: int = -1

func _get_property_list() -> Array:
	var properties: Array = []

	properties.append({
		"name": "card_category",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": GameActions.ACTION_CATEGORY
	})

	var action_options = GameActions.ACTIONS
	
	match(card_category):
		GameActions.ACTION_CATEGORY.INTERACTION:
			return GameActions.ACTIONS
		GameActions.ACTION_CATEGORY.COMBAT:
			return GameActions.ACTION_CATEGORY
		GameActions.ACTION_CATEGORY.INVENTORY:
			return GameActions.ACTION_CATEGORY
		_:
			return null

	properties.append({
		"name": "card_type",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": room_options
	})

	return properties

var card_is_active : bool = false:
	set(new):
		card_is_active = new
		if new == false:
			EventBus.card_deselected.emit()
		if new == true:
			EventBus.selected_card_changed.emit(card_type)

var interaction_texture_lookup: Dictionary[GameActions.ACTIONS, CompressedTexture2D] = {
	GameActions.ACTIONS.TELEPORT: preload("res://assets/cards/interactions/teleport.png"),
	GameActions.ACTIONS.OPEN: preload("res://assets/cards/interactions/key.png"),
	GameActions.ACTIONS.LOCK: preload("res://assets/cards/interactions/lock.png"),
	GameActions.ACTIONS.REST: preload("res://assets/cards/interactions/rest.png"),
	GameActions.ACTIONS.COMPASS: preload("res://assets/cards/interactions/compass.png"),
}

var combat_textures_lookup: Dictionary[GameActions.COMBAT_ACTIONS, CompressedTexture2D] = {
	GameActions.COMBAT_ACTIONS.RANGED_ATTACK: preload("res://assets/cards/interactions/arrow.png"),
	GameActions.COMBAT_ACTIONS.MELEE_ATTACK: preload("res://assets/cards/interactions/melee.png"),
	GameActions.COMBAT_ACTIONS.WAIT: preload("res://assets/cards/interactions/wait.png"),
	GameActions.COMBAT_ACTIONS.ICE_BOLT: preload("res://assets/cards/interactions/ice_bolt.png"),
}

var inventory_textures_lookup: Dictionary[GameActions.INVENTORY_ITEMS, CompressedTexture2D] = {
	GameActions.INVENTORY_ITEMS.HUMAN_DOLL: preload("res://assets/cards/inventory/human_doll.png"),
	GameActions.INVENTORY_ITEMS.GOBLIN_DOLL: preload("res://assets/cards/inventory/goblin_doll.png"),
	GameActions.INVENTORY_ITEMS.CROWN: preload("res://assets/cards/inventory/crown.png"),
}

func get_texture() -> CompressedTexture2D:
	if card_category == GameActions.ACTION_CATEGORY.INTERACTION:
		return interaction_texture_lookup[card_type]
	elif card_category == GameActions.ACTION_CATEGORY.COMBAT:
		return combat_textures_lookup[card_type]
	elif card_category == GameActions.ACTION_CATEGORY.COMBAT:
		return combat_textures_lookup[card_type]
	else:
		return preload("res://assets/cards/placeholder/placeholder.png")
