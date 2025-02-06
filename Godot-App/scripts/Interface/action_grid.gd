class_name ActionGrid
extends GridContainer

# Preload the scene at compile time
var slot_scene: PackedScene = preload("res://scenes/Interface/action_slot.tscn")

func display(object:Objects, node_object:Node3D):
	# Clear existing children
	for child in get_children():
		child.queue_free()
	
	# Add new slots
	for action in object.Actions:
		if action != null:
			var slot = slot_scene.instantiate()
			add_child(slot)
			slot.display(action, node_object)
