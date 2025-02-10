class_name InventoryDialog
extends PanelContainer

@onready var grid_container: ItemGrid = %GridContainer

func open():
	show()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	grid_container.display(GameManager.player.inventory.get_items())

func _on_close_button_pressed(): 
	InterfaceManager.close_dialog()
