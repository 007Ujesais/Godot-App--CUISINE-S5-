extends CharacterBody3D

const SPEED = 2.0
const ROTATION_SPEED = 10.0

@onready var camera_point = $camera_point

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animation_player = $Visuals/player/AnimationPlayer
@onready var visuals = $Visuals

var walking = false

var inventory:Inventory = Inventory.new()

var item_object:Item = null
var nearby_object:Node3D = null

var cane_take_object = false

func _ready():
	GameManager.set_player(self)
	animation_player.set_blend_time("idle", "walk", 0.3)
	animation_player.set_blend_time("walk", "idle", 0.3)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		var iso_direction = Vector3(
		-direction.x + direction.z,
		0,
		-direction.x - direction.z
		).normalized()
		
		var target_angle = atan2(iso_direction.x, iso_direction.z)
		visuals.rotation.y = lerp_angle(visuals.rotation.y, target_angle, ROTATION_SPEED * delta)
		
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

	if Input.is_action_just_pressed("interact") and cane_take_object:
		pick_up_object(item_object)

func pick_up_object(item:Item):
	print("Objet ramassé : ", item.name)
	inventory.add_item(item)
	
	nearby_object.queue_free()
	item_object = null
