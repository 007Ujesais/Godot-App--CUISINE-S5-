extends Node3D

var is_player_near = false
@export var item:Item

func _ready():	
	add_to_group("interactable")
	
	var instance = item.scene.instantiate()
	add_child(instance)

func _on_area_entered(area):
	if area.is_in_group("player"):
		is_player_near = true
		print("Joueur proche: " + item.name)
		can_take_it()

func _on_area_exited(area):
	if area.is_in_group("player"):
		is_player_near = false
		print("Joueur n'est plus proche de: " + item.name)
		cant_take_it()

func can_take_it():
	if GameManager.player:
		GameManager.player.cane_take_object = true
		GameManager.player.nearby_object = self
		GameManager.player.item_object = item

func cant_take_it():
	if GameManager.player:
		GameManager.player.cane_take_object = false
		GameManager.player.nearby_object = null
		GameManager.player.item_object = null
