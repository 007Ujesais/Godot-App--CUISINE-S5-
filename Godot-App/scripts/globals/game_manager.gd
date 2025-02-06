extends Node

var player: Player = null
var camera: CameraRig = null

func set_player(player_node: Player):
	player = player_node
	
func set_camera(camera_node: CameraRig):
	camera = camera_node

func get_camera() -> CameraRig:
	return camera
