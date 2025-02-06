class_name CameraRig
extends Node3D

@onready var background_viweport = %background_viweport
@onready var forground_viweport = %forground_viweport

@onready var background_camera = %background_camera
@onready var forground_camera = %forground_camera

@onready var base_camera: Camera3D = %base_camera

# Vitesse de lissage de la caméra (ajustez selon vos besoins)
@export var smooth_speed: float = 1.7

func _ready():
	GameManager.set_camera(self)
	resize()

func resize():
	background_viweport.size = DisplayServer.window_get_size()
	forground_viweport.size = DisplayServer.window_get_size()

func _process(delta):
	# Interpolation de la position et de la rotation de la caméra
	interpolate_camera(background_camera, delta)
	interpolate_camera(forground_camera, delta)

func interpolate_camera(camera: Camera3D, delta: float):
	if GameManager.player and GameManager.player.camera_point:
		# Interpolation de la position
		var target_position = GameManager.player.camera_point.global_transform.origin
		camera.global_transform.origin = camera.global_transform.origin.lerp(target_position, smooth_speed * delta)

		# Interpolation de la rotation
		var target_rotation = GameManager.player.camera_point.global_transform.basis
		camera.global_transform.basis = camera.global_transform.basis.slerp(target_rotation, smooth_speed * delta)

func get_base_camera():
	return forground_camera
