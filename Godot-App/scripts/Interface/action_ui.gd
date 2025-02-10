class_name ActionUI
extends Node3D

@onready var canvas_layer: CanvasLayer = %CanvasLayer
@onready var container: Control = %Container
@onready var action_grid: ActionGrid = %ActionGrid

func _ready():
	hide_actions()

func _process(delta):
	var position_2d = GameManager.camera.get_base_camera().unproject_position(global_transform.origin)
	container.position = position_2d

func show_actions(node_object:Node3D):
	container.show()
	if node_object is interactive_object:
		if node_object.object:
			action_grid.display(node_object)

func hide_actions():
	InterfaceManager.close_dialog()
	container.hide()
