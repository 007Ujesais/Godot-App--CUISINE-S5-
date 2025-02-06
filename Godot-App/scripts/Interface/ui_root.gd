extends CanvasLayer

@export var all_recipes:ResourceGroup

@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var cooking_dialog: CookingDialog = %CookingDialog

var _all_recipes:Array[Recipe] = []

func _ready():
	all_recipes.load_all_into(_all_recipes)
		
func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_released("cooking"):
			cooking_dialog.open(_all_recipes,GameManager.player.inventory)

		if event.is_action_released("inventory"):
			inventory_dialog.open(GameManager.player.inventory)
			
