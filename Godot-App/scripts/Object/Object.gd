extends Area3D

# Référence au joueur et au point d'attache
var player: CharacterBody3D = null
var attach_point: NodePath = NodePath()  # Chemin vers le point d'attache du joueur
var is_attached: bool = false

# Vitesse de suivi (ajustable pour plus ou moins de fluidité)
var follow_speed: float = 10.0

func _on_body_entered(body):
	if body.is_in_group("player") and not is_attached:
		print("You take an object")
		player = body as CharacterBody3D  # Cast en CharacterBody3D
		# Vérifie que le point d'attache existe
		if player.has_node(attach_point):
			is_attached = true
			set_physics_process(false)  # Désactive la physique de l'objet
		else:
			print("Attach point not found!")

func _process(delta):
	if is_attached and player:
		# Récupère la position du point d'attache du joueur
		var target_position = player.get_node(attach_point).global_transform.origin
		# Interpole la position de l'objet pour un suivi fluide
		global_transform.origin = global_transform.origin.lerp(target_position, follow_speed * delta)
