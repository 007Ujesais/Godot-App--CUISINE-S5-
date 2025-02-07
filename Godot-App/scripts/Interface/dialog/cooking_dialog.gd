class_name CookingDialog
extends PanelContainer

@export var slot_scene: PackedScene

@onready var recipe_list: ItemList = %RecipeList
@onready var ingredient_container: ItemGrid = %IngredientContainer
@onready var result_container: ItemGrid = %ResultContainer

var _inventory:Inventory
var _selected_recipe:Recipe

func open(recipes:Array[Recipe], inventory: Inventory):
	_inventory = inventory
	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	recipe_list.clear()
	
	for recipe in recipes:
		var index = recipe_list.add_item(recipe.name)
		recipe_list.set_item_metadata(index, recipe)
		
	recipe_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_recipe_list_item_selected(index: int) -> void:
	recipe_list.select(index)
	_selected_recipe = recipe_list.get_item_metadata(index)
	ingredient_container.display(_selected_recipe.ingredients)
	result_container.display(_selected_recipe.results)

func _on_close_button_pressed(): 
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_cooking_button_pressed() -> void:
	for item in _selected_recipe.ingredients:
		_inventory.remove_item(item)
	
	for item in _selected_recipe.results:
		_inventory.add_item(item)
