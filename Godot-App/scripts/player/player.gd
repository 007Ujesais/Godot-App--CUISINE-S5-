class_name Player
extends CharacterBody3D

# Constantes pour la vitesse et la rotation
const SPEED: float = 2.0
const ROTATION_SPEED: float = 7.0

# Références aux nœuds de la scène
@onready var camera_point: Node3D = $camera_point
@onready var animation_player: AnimationPlayer = $Visuals/player/AnimationPlayer
@onready var visuals: Node3D = $Visuals

# Récupération de la gravité du projet
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# États du joueur
var walking: bool = false
var can_interact_object: bool = false

# Inventaire
var inventory: Inventory = Inventory.new()

# Objets à proximité
var nearby_object: Objects = null
var node_object: Node3D = null

func _ready():
	GameManager.set_player(self)
	# Ajout des transitions fluides entre les animations
	animation_player.set_blend_time("idle", "walk", 0.3)
	animation_player.set_blend_time("walk", "idle", 0.3)

func _physics_process(delta: float):
	_apply_gravity(delta)
	_handle_movement(delta)
	_handle_interaction()

	move_and_slide()

# Applique la gravité si le joueur n'est pas au sol
func _apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y -= gravity * delta

# Gère les déplacements et l'animation du joueur
func _handle_movement(delta: float):
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		var iso_direction: Vector3 = Vector3(
			-direction.x + direction.z,
			0,
			-direction.x - direction.z
		).normalized()

		# Rotation fluide du personnage
		var target_angle: float = atan2(iso_direction.x, iso_direction.z)
		visuals.rotation.y = lerp_angle(visuals.rotation.y, target_angle, ROTATION_SPEED * delta)

		# Lancement de l'animation de marche si nécessaire
		if not walking:
			walking = true
			animation_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		# Retour à l'animation d'idle si le joueur s'arrête
		if walking:
			walking = false
			animation_player.play("idle")

# Gère les interactions avec les objets
func _handle_interaction():
	if Input.is_action_just_pressed("interact") and nearby_object:
		print("Interaction avec : " + nearby_object.name)

		if GameInteraction.pick and not GameInteraction.drop:
			pick_object(nearby_object)
		elif GameInteraction.drop and not GameInteraction.pick and inventory._content.size() > 0:
			if nearby_object is Recipe:
				place_object(nearby_object)
			else:
				print("Impossible de placer cet objet ici.")

	# Permet de déposer un objet même s'il n'y a rien à proximité
	elif Input.is_action_just_pressed("interact") and GameInteraction.drop and not GameInteraction.pick and inventory._content.size() > 0 and !can_interact_object:
		drop_all_objects()

# Ramasse un objet et l'ajoute à l'inventaire
func pick_object(item: Item):
	print("Objet ramassé: ", item.name)
	inventory.add_item(item)

# Dépose un objet depuis l'inventaire
func drop_all_objects():
	if inventory._content.is_empty():
		print("⚠️ Aucun objet à déposer.")
		return
	
	for item in inventory.get_items():
		print("🗑️ Objet déposé :", item.name)
		inventory.remove_item(item)
	
	print("✅ Tous les objets ont été déposés.")


# Place un objet dans un emplacement spécifique
func place_object(recipe: Recipe):
	# On récupère la liste des ingrédients que le joueur possède
	var ingredients_to_place = []
	for item in inventory._content:
		if item in recipe.ingredients and item not in recipe.placed_ingredients:
			ingredients_to_place.append(item)
			print("Objet placé dans un : ", recipe.name)

	# Ajout des ingrédients à la recette
	for item in ingredients_to_place:
		recipe.add_ingredient(item)
		inventory.remove_item(item)
		# Affichage du pourcentage de progression
		var completion = recipe.get_completion_percentage()
		print("Progression de la recette :", completion, "%")
