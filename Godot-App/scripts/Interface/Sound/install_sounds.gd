extends Node

@export var root_path: NodePath

@onready var root_node: Node = null
@onready var sounds: Dictionary = {}

func _ready() -> void:
	if root_path:
		root_node = get_node(root_path)
		if not root_node:
			push_error("❌ Erreur : root_path invalide pour Interface Sounds!")
	else:
		print("⚠️ Aucun root_path défini.")

	# Création et stockage des sons
	sounds = {
		"UI_Hover": create_audio_player("res://assets/Sound/UI_Hover.ogg"),
		"UI_Click": create_audio_player("res://assets/Sound/UI_Click.ogg"),
	}

	# Ajouter chaque audio player à ce nœud
	for sound in sounds.values():
		if sound:  # Vérifier si la création a réussi
			add_child(sound)

	# Installer les sons si un root_node est défini
	if root_node:
		install_sounds(root_node)

# Crée un lecteur audio pour un chemin donné
func create_audio_player(sound_path: String) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	var stream = load(sound_path)
	
	if stream:
		player.stream = stream
		# Vérifier si le bus "Sfx" existe avant d'assigner
		if AudioServer.get_bus_index("Sfx") != -1:
			player.bus = "Sfx"
		else:
			print("⚠️ Le bus 'Sfx' n'existe pas. Assurez-vous qu'il est défini dans l'audio.")
	else:
		push_warning("⚠️ Impossible de charger le son :", sound_path)

	return player

# Associe les sons aux boutons de l'interface
func install_sounds(node: Node) -> void:
	for child in node.get_children():
		if child is Button or child is OptionButton or child is TextureButton:
			# Vérifier si le signal est déjà connecté avant de le refaire
			if not child.mouse_entered.is_connected(ui_sfx_play.bind("UI_Hover")):
				child.mouse_entered.connect(ui_sfx_play.bind("UI_Hover"))
			if not child.pressed.is_connected(ui_sfx_play.bind("UI_Click")):
				child.pressed.connect(ui_sfx_play.bind("UI_Click"))
		
		# Récursivité pour parcourir toute l'interface
		install_sounds(child)

# Joue un effet sonore spécifique
func ui_sfx_play(sound: String) -> void:
	var player = sounds.get(sound, null)
	if player:
		player.stop()
		player.play()
