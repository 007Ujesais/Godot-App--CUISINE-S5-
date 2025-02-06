class_name ItemGrid
extends GridContainer

# Preload the scene at compile time
var slot_scene: PackedScene = preload("res://scenes/Interface/item_slot.tscn")

func display(items: Array[Item]):
	# Clear existing children
	for child in get_children():
		child.queue_free()
	
	# Add new slots
	for item in items:
		if item != null:
			var slot = slot_scene.instantiate()
			add_child(slot)
			slot.display(item)
