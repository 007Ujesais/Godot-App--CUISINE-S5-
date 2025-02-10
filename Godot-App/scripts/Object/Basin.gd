class_name Basin
extends Objects

var recipe: Recipe
var placed_ingredients: Array[Item] = []
var planel_ui: ActionSlot = null
@warning_ignore("unused_private_class_variable")
var _inventory: Inventory = null
var percentage: int = 0
var in_preparation: bool = false

func place_item(item: Item):
	if not GameManager.player.inventory:
		print("Erreur: Inventaire du joueur non défini")
		return

	placed_ingredients.append(item)
	GameManager.player.inventory.remove_item(item)
	
	verify_placed_ingredients()
	
	planel_ui.show_result(self)

func verify_placed_ingredients() -> bool:
	if recipe == null:
		print("Erreur: Aucune recette assignée au Basin")
		return false

	var required_ingredients = recipe.ingredients.duplicate()
	percentage = 0

	for item in placed_ingredients:
		if item in required_ingredients:
			required_ingredients.erase(item)
			@warning_ignore("narrowing_conversion")
			percentage += 100.0 / recipe.ingredients.size()

	return required_ingredients.is_empty()

func set_placed_ingredients(item: Array[Item]):
	in_preparation = false
	placed_ingredients.clear()
	placed_ingredients.append_array(item)
	
func get_placed_ingredients():
	percentage = 0
	for item in recipe.results:
		if item in placed_ingredients:
			placed_ingredients.erase(item)
			GameManager.player.inventory.add_item(item)
