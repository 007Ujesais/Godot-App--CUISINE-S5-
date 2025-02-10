class_name MenuAction
extends PanelContainer

@onready var button: Button = %Button
var _action: Action
var _node_object:Node3D
var _parent_panel:PanelContainer

func display(action: Action, node_object:Node3D, node_ui:PanelContainer):
	_node_object = node_object
	_parent_panel = node_ui
	if action:
		_action = action
		button.text = action.name

func _on_button_pressed() -> void:
	if _action and _action.scripts:
		print("Action cliquée : " + _action.name)
		
		var script_instance = Node.new()
		script_instance.set_script(_action.scripts)

		if script_instance.has_method("execute"):
			script_instance.execute(_node_object,_parent_panel)
		else:
			print_debug("⚠️ Le script ne contient pas de méthode 'execute'")
	else:
		print_debug("⚠️ Action ou script non défini !")
