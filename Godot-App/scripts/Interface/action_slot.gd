class_name ActionSlot
extends PanelContainer

@onready var action_control: MenuAction = %ActionControl
@onready var result_control: MenuResult = %ResultControl

var _node_object:Node3D

func _ready():
	show_action()
	hide_result()

func display(action: Action, node_object:Node3D):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_node_object = node_object
	action_control.display(action,_node_object, self)

func show_action():
	action_control.show()
	
func hide_action():
	action_control.hide()
	
func show_result(basin:Basin):
	result_control.show()
	#hide_action()
	result_control.display(basin)
	
func hide_result():
	result_control.hide()
