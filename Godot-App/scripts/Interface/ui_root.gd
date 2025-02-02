extends CanvasLayer

@onready var inventory_dialog: InventoryDialog = %InventoryDialog

func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_released("inventory"):
			inventory_dialog.open(GameManager.player.inventory)
