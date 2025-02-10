class_name MenuResult
extends PanelContainer

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer_container: TimerContainer = %TimerContainer
@onready var h_box_container_button_result_menu: HBoxContainer = %HBoxContainerButtonResultMenu

var current_progression: float = 0
var target_progression: float = 0

@onready var button_add: Button = %Button_Add
@onready var button_cook: Button = %Button_Cook

var _basin: Basin

func _ready():
	timer_container.hide()
	button_add_priority()

func display(basin: Basin):
	_basin = basin
	timer_container.hide()
	progress_bar.show()
	h_box_container_button_result_menu.show()
	button_add_priority()
	
	set_progress_bar()
	

func set_progress_bar():
	if _basin:
		current_progression = float(_basin.percentage)
	target_progression = current_progression

	var tween = create_tween()
	tween.tween_property(progress_bar, "value", target_progression, 1.5) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	current_progression = target_progression
	
	verify_progression()

func verify_progression():
	if current_progression >= 100:
		button_cook_priority()

func set_progress_time():
	timer_container.start(_basin)

func button_add_priority():
	button_add.show()
	button_cook.hide()
	
func button_cook_priority():
	button_add.hide()
	button_cook.show()

func _on_button_add_pressed() -> void:
	if _basin:
		for item in _basin.recipe.ingredients:
			if item in GameManager.player.inventory.get_items():
				_basin.place_item(item)

func _on_button_cook_pressed() -> void:
	progress_bar.hide()
	if _basin:
		_basin.in_preparation = true
		progress_bar.value = progress_bar.min_value
		
		h_box_container_button_result_menu.hide()
		
		timer_container.show()
		
		set_progress_time()
