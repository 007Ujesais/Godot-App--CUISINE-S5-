class_name CookingDialog
extends PanelContainer

@export var all_recipes:ResourceGroup

@onready var recipe_list: ItemList = %RecipeList
@onready var ingredient_container: ItemGrid = %IngredientContainer
@onready var result_container: ItemGrid = %ResultContainer
@onready var cooking_button: Button = %CookingButton

var _inventory:Inventory

var _basin:Basin
var _selected_recipe:Recipe
var _all_recipes:Array[Recipe] = []

func _ready():
	all_recipes.load_all_into(_all_recipes)
	set_elements()

func set_elements():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_basin = GameManager.player.curent_basin
	_inventory = GameManager.player.inventory

func open():
	set_elements()
	show()
	
	if _basin.percentage <= 0:
		cooking_button.disabled = false

	recipe_list.clear()
	
	for recipe in _all_recipes:
		var index = recipe_list.add_item(recipe.name)
		recipe_list.set_item_metadata(index, recipe)
		
	recipe_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_recipe_list_item_selected(index: int) -> void:
	recipe_list.select(index)
	_selected_recipe = recipe_list.get_item_metadata(index)
	ingredient_container.display(_selected_recipe.ingredients)
	result_container.display(_selected_recipe.results)
	
	if _basin.percentage <= 0:
		for item in _inventory.get_items():
			if _selected_recipe.ingredients.has(item):
				cooking_button.disabled = false
				break
			else:
				cooking_button.disabled = true

func _on_close_button_pressed(): 
	InterfaceManager.close_dialog()
	GameManager.player.animation_player.play("idle2")


func _on_cooking_button_pressed() -> void:
	if not _basin.in_preparation:
		_basin.recipe = _selected_recipe
		for item in _selected_recipe.ingredients:
			if item in _inventory.get_items():
				_basin.place_item(item)
	start_cooking()

func start_cooking():
	cooking_button.disabled = true
	GameManager.player.animation_player.play("cooking")
