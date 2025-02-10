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
		if object is Basin:
			if object.placed_ingredients.is_empty():
				instance_ui.show_actions(self)
		if object is Source:
			instance_ui.show_actions(self)

		is_player_near = true
		print("Joueur proche: " + object.name)
		can_interact_it()

func _on_area_exited(area):
	if area.is_in_group("player"):
		if object is Basin:
			if object.placed_ingredients.is_empty():
				instance_ui.hide_actions()
		if object is Source:
			instance_ui.hide_actions()

		is_player_near = false
		print("Joueur n'est plus proche de: " + object.name)
		cant_interact_it()

func can_interact_it():
	if object is Basin and object.recipe:
		var HB_Button_result_menu = instance_ui.find_child("HBoxContainerButtonResultMenu", true, false)
		if HB_Button_result_menu and object.placed_ingredients != object.recipe.results and !object.in_preparation:
			HB_Button_result_menu.show()
			
		var Claim_button = instance_ui.find_child("ButtonClaim", true, false)
		if Claim_button:
			Claim_button.disabled = false

func cant_interact_it():
	if object is Basin: 
		var HB_Button_result_menu = instance_ui.find_child("HBoxContainerButtonResultMenu", true, false)
		if HB_Button_result_menu:
			HB_Button_result_menu.hide()
			
		var Claim_button = instance_ui.find_child("ButtonClaim", true, false)
		if Claim_button:
			Claim_button.disabled = true
