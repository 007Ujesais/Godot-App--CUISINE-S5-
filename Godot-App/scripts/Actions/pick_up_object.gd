extends Node

func execute(node: Node3D):
	if node:
		if node is interactive_object:
			if node.object is Item:
				print("Objet ramassé :", node.object.name)
				GameManager.player.pick_object(node.object)
				#node.queue_free()
