extends Node3D

var is_player_near = false

func _ready():
	add_to_group("interactable")

func _on_area_entered(area):
	if area.is_in_group("player"):
		is_player_near = true
		print("Joueur proche de l'objet")
		can_take_it()

func _on_area_exited(area):
	if area.is_in_group("player"):
		is_player_near = false
		print("Joueur n'est plus proche de l'objet")
		cant_take_it()

func can_take_it():
	if GameManager.player:
		GameManager.player.cane_take_object = true
		GameManager.player.nearby_object = self

func cant_take_it():
	if GameManager.player:
		GameManager.player.cane_take_object = false
		GameManager.player.nearby_object = null
