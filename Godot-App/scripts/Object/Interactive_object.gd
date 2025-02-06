class_name interactive_object
extends Node3D

var is_player_near = false
@export var object:Objects
var action_ui: PackedScene = preload("res://scenes/Interface/action_ui.tscn")
var instance_ui

func _ready():
	instance_ui = action_ui.instantiate()
	add_child(instance_ui)
	if object is Item:
		var instance = object.scene.instantiate()
		add_child(instance)

func _on_area_entered(area):
	if area.is_in_group("player"):
		is_player_near = true
		print("Joueur proche: " + object.name)
		instance_ui.show_actions(object, self)
		can_interact_it()

func _on_area_exited(area):
	if area.is_in_group("player"):
		is_player_near = false
		print("Joueur n'est plus proche de: " + object.name)
		instance_ui.hide_actions()
		cant_interact_it()

func can_interact_it():
	GameInteraction.pick = false
	
	if object is Item:
		GameInteraction.can_pick()
	if object is Recipe:
		GameInteraction.can_drop()
		
	if GameManager.player:
		GameManager.player.can_interact_object = true
		GameManager.player.nearby_object = object
		GameManager.player.node_object = self
		

func cant_interact_it():
	GameInteraction.pick = false
	
	if GameManager.player:
		GameManager.player.can_interact_object = false
		GameManager.player.nearby_object = null
		GameManager.player.node_object = null
