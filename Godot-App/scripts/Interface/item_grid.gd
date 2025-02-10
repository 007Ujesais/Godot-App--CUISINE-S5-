class_name ItemGrid
extends ScrollContainer

@export var slot_scene: PackedScene = preload("res://scenes/Interface/item_slot.tscn")
@onready var grid_container_item_slot: GridContainer = %GridContainerItemSlot 
@export var column_grid: int = 4

func _ready() -> void:
	grid_container_item_slot.columns = column_grid

func display(items: Array[Item]):
	clear_child()
	for item in items:
		if item != null:
			var slot: ItemSlot = slot_scene.instantiate() 
			grid_container_item_slot.add_child(slot)
			slot.display(item)
			
func display_with_button(items: Array[Item]):
	clear_child()
	for item in items:
		if item != null:
			var slot: ItemSlot = slot_scene.instantiate() 
			grid_container_item_slot.add_child(slot)
			slot.display_with_add_button(item)

func clear_child():
	for child in grid_container_item_slot.get_children():
		child.queue_free()
