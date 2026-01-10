extends Control
class_name Inventory

## used to render the inventory
@export var inventory_items : Array[Action]
var max_inventory_size: int = 4

@onready var center_container: CenterContainer = $CenterContainer
@onready var inventory_grid: GridContainer = $CenterContainer/PanelContainer/InventoryGrid
const INVENTORY_SLOT = preload("uid://dedi2i3eaqh4i")

func _ready():
	# remove development slots
	for slot in inventory_grid.get_children():
		slot.queue_free()

	for n in max_inventory_size:
		var new_slot : TextureRect = INVENTORY_SLOT.instantiate()
		inventory_grid.add_child(new_slot)
		
		if inventory_has_item_at(n):
			var new_item = TextureRect.new()
			new_item.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT, Control.PRESET_MODE_KEEP_SIZE, 5)
			var inventory_item = inventory_items[n] as Action
			new_item.texture = inventory_item.texture
			new_slot.add_child(new_item)
		
	#var inventory_slots = get_tree().get_nodes_in_group('inventory_slot'):

func inventory_has_item_at(idx : int):
	return idx < inventory_items.size()

func on_press_inventory_button():
	center_container.visible = not center_container.visible
