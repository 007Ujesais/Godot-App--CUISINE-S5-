extends PanelContainer

@onready var button: Button = %Button
var _action: Action
var _node_object:Node3D

func display(action: Action, node_object:Node3D):
	_node_object = node_object
	if action:
		_action = action
		button.text = action.name
	else:
		print_debug("⚠️ L'action est null !")

func _on_button_pressed() -> void:
	if _action and _action.scripts:
		print("Action cliquée : " + _action.name)

		# Créer un nouvel objet avec le script attaché
		var script_instance = Node.new()
		script_instance.set_script(_action.scripts)

		# Vérifier si la fonction existe dans le script et l'exécuter
		if script_instance.has_method("execute"):
			script_instance.execute(_node_object)  # Assure-toi que `node_object` est défini
		else:
			print_debug("⚠️ Le script ne contient pas de méthode 'execute'")
	else:
		print_debug("⚠️ Action ou script non défini !")
