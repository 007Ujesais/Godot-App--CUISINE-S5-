extends CharacterBody3D

const SPEED = 2.0
const JUMP_VELOCITY = 4.5

@onready var camera_point = $camera_point

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animation_player = $Visuals/player/AnimationPlayer
@onready var visuals = $Visuals

var walking = false

# Variable pour stocker l'objet proche
var nearby_object: Node3D = null

func _ready():
	GameManager.set_player(self)
	animation_player.set_blend_time("idle", "walk", 0.2)
	animation_player.set_blend_time("walk", "idle", 0.2)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		visuals.look_at(direction + position)
		if !walking:
			walking = true
			animation_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if walking:
			walking = false
			animation_player.play("idle")

	move_and_slide()

	# Gestion de l'interaction avec l'objet
	if Input.is_action_just_pressed("interact") and nearby_object != null:
		pick_up_object(nearby_object)

func _on_area_entered(area):
	# Vérifie si l'objet entrant est un objet interactif (comme un Plat)
	if area.is_in_group("interactable"):
		nearby_object = area.get_parent()  # Stocke l'objet proche
		print("Objet proche détecté : ", nearby_object.name)

func _on_area_exited(area):
	# Vérifie si l'objet qui sort est l'objet interactif
	if area.is_in_group("interactable") and area.get_parent() == nearby_object:
		nearby_object = null  # Réinitialise l'objet proche
		print("Objet n'est plus proche")

func pick_up_object(object):
	# Logique pour ramasser l'objet
	print("Objet ramassé : ", object.name)
	object.queue_free()  # Supprime l'objet de la scène
	nearby_object = null  # Réinitialise l'objet proche


func _on_area_3d_area_entered(area):
	pass # Replace with function body.
