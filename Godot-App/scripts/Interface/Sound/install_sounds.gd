extends Node

@export var root_path: NodePath
@export var button_classes: Array[StringName] = ["Button", "OptionButton", "TextureButton", "TabContainer"]

@onready var root_node: Node = get_node(root_path) if root_path else null

# Création des instances des lecteurs audio
@onready var sounds := {
	"UI_Hover": create_audio_player("res://assets/Sound/UI_Hover.ogg"),
	"UI_Click": create_audio_player("res://assets/Sound/UI_Click.ogg"),
}

func _ready() -> void:
	assert(root_node, "Invalid root path for Interface Sounds!")

	# Connecte les sons aux boutons et autres composants UI
	install_sounds(root_node)

# Fonction pour créer un AudioStreamPlayer configuré
func create_audio_player(sound_path: String) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.stream = load(sound_path)
	player.bus = "Sfx"
	add_child(player)  # Ajoute directement au nœud parent
	return player

# Ajoute les sons aux éléments de l'interface utilisateur
func install_sounds(node: Node) -> void:
	for child in node.get_children():
		# Vérifie si le type de `child` est dans `button_classes`
		if child.get_class() in button_classes:
			child.mouse_entered.connect(ui_sfx_play.bind("UI_Hover"))
			child.pressed.connect(ui_sfx_play.bind("UI_Click"))

			# Gestion spécifique pour `TabContainer`
			if child is TabContainer:
				child.tab_hovered.connect(ui_sfx_play.bind("UI_Hover"))
				child.tab_clicked.connect(ui_sfx_play.bind("UI_Hover"))

		# Récursion pour parcourir toute l'arborescence
		install_sounds(child)

# Joue un son s'il existe dans le dictionnaire
func ui_sfx_play(sound: String) -> void:
	var player = sounds.get(sound, null)
	if player:
		player.stop()  # Stoppe le son s'il est déjà en cours
		player.play()
