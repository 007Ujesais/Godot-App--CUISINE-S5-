class_name ResourceDialog
extends PanelContainer

@export var all_resouce:ResourceGroup

@onready var items_container: ItemGrid = %ItemsContainer

var _all_resource:Array[Item] = []

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	all_resouce.load_all_into(_all_resource)

func open():
	show()
	if GameManager.player.curent_source:
		_all_resource = GameManager.player.curent_source._content._content
		items_container.display_with_button(_all_resource)


func _on_close_button_pressed() -> void:
	InterfaceManager.close_dialog()
