class_name Recipe
extends Objects

@export var ingredients: Array[Item] = []
@export var results: Array[Item] = []

# Liste des ingrédients placés
var placed_ingredients: Array[Item] = []

# Calcule le pourcentage d'ingrédients placés
func get_completion_percentage() -> float:
	if ingredients.is_empty():
		return 0.0  # Évite la division par zéro
	
	var placed_count = 0
	for ingredient in ingredients:
		if ingredient in placed_ingredients:
			placed_count += 1

	return (placed_count * 100.0) / ingredients.size()

# Ajoute un ingrédient à la recette
func add_ingredient(item: Item):
	if item in ingredients and item not in placed_ingredients:
		placed_ingredients.append(item)
		print("Ingrédient ajouté :", item.name)
		print("Progression : ", get_completion_percentage(), "%")
	else:
		print("Cet ingrédient n'est pas requis ou déjà ajouté.")

# Vérifie si la recette est complète
func is_completed() -> bool:
	return get_completion_percentage() >= 100.0
