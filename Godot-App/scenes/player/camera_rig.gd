extends Node3D

@onready var background_viweport = $base_camera/background_viewport_container/background_viweport
@onready var forground_viweport = $base_camera/forground_viewport_container/forground_viweport

@onready var background_camera = $base_camera/background_viewport_container/background_viweport/background_camera
@onready var forground_camera = $base_camera/forground_viewport_container/forground_viweport/forground_camera

# Vitesse de lissage de la caméra (ajustez selon vos besoins)
var smooth_speed: float = 7.0

func _ready():
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
