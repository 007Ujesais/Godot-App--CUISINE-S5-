extends Control

@export var loading_bar: ProgressBar
@export var percentage_label: Label

var scene: String
var progress: Array = []

var update: float = 0.0
var is_loading_complete: bool = false
var delay_timer: float = 0.0

func _ready():
	scene = "res://scenes/Game/World.tscn"
	ResourceLoader.load_threaded_request(scene)

func _process(delta):
	ResourceLoader.load_threaded_get_status(scene, progress)
	
	if progress[0] > update:
		update = progress[0]
	
	if loading_bar.value < update:
		loading_bar.value = lerp(loading_bar.value, update, 5 * delta)
	
	percentage_label.text = str(int(loading_bar.value * 100)) + " %"
	
	if progress[0] >= 1.0 and !is_loading_complete:
		is_loading_complete = true
		delay_timer = 3.0
	
	if is_loading_complete:
		delay_timer -= delta
		if delay_timer <= 0.0:
			var loaded_scene = ResourceLoader.load_threaded_get(scene)
			if loaded_scene:
				get_tree().change_scene_to_packed(loaded_scene)
