extends Node

func execute(node: Node3D):
	if node:
		print("Objet ramassé :", node.name)
		node.queue_free()
