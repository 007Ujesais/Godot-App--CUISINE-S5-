extends Node3D

# Variable pour savoir si le joueur est à proximité
var is_player_near = false

func _ready():
	# Ajoute l'objet au groupe "interactable"
	add_to_group("interactable")

func _on_area_entered(area):
	# Vérifie si le joueur est entré dans la zone
	if area.is_in_group("player"):
		is_player_near = true
		print("Joueur proche de l'objet")

func _on_area_exited(area):
	# Vérifie si le joueur est sorti de la zone
	if area.is_in_group("player"):
		is_player_near = false
		print("Joueur n'est plus proche de l'objet")
