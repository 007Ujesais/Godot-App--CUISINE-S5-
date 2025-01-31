extends Node3D

@onready var background_viweport = $base_camera/background_viewport_container/background_viweport
@onready var forground_viweport = $base_camera/forground_viewport_container/forground_viweport

@onready var background_camera = $base_camera/background_viewport_container/background_viweport/background_camera
@onready var forground_camera = $base_camera/forground_viewport_container/forground_viweport/forground_camera

# Called when the node enters the scene tree for the first time.
func _ready():
	resize();

func  resize():
	background_viweport.size = DisplayServer.window_get_size()
	forground_viweport.size = DisplayServer.window_get_size()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background_camera.global_transform = GameManager.player.camera_point.global_transform
	forground_camera.global_transform = GameManager.player.camera_point.global_transform
