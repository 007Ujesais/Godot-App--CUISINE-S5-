class_name TimerContainer
extends GridContainer

@onready var progress_timer: ProgressBar = %ProgressTimer
@onready var label_time: Label = %LabelTime
@onready var button: Button = %ButtonClaim


var _timer: Dictionary = {}  
var _basin: Basin
var time: float = 0.0
var max_time: float = 0.0  
var time_start: bool = false 

func _process(delta: float):
	if _basin:
		if time_start:
			time += delta 
			if time >= max_time:
				time = max_time 
				time_start = false

			var minute = int(time) / 60
			var second = int(time) % 60
			label_time.text = "%02d:%02d" % [minute, second]

			progress_timer.value = (time / max_time) * 100
		
		if progress_timer.value >= 100:
			
			label_time.hide()
			progress_timer.hide()
			
			_basin.set_placed_ingredients(_basin.recipe.results)
			button.show()

func start(basin:Basin):
	
	button.hide()
	label_time.show()
	progress_timer.show()
	
	_basin = basin
	_timer = _basin.recipe.launch_time
	max_time = _timer["h"] * 3600 + _timer["m"] * 60 + _timer["s"]  
	time = 0
	progress_timer.max_value = 100  
	progress_timer.value = 0
	time_start = true 

func _on_button_pressed() -> void:
	
	_timer = {}
	time = 0
	max_time = 0
	time_start = false
	label_time.text = "00:00"
	progress_timer.value = 0
	
	_basin.get_placed_ingredients()
	_basin.planel_ui._ready()
