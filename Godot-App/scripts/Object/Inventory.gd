class_name Inventory
extends Resource

@export var _max_size: int = 20 :
	set(value):
		_max_size = max(value, _content.size())  # Empêcher la réduction sous la taille actuelle
		resize_inventory()

@export var _content: Array[Item] = []:
	set(value):
		_content = value
		resize_inventory()

# Initialisation sécurisée
func _init() -> void:
	if _content.size() != _max_size:
		resize_inventory()

# Assure la taille correcte du contenu
func resize_inventory():
	_content.resize(_max_size)
	for i in range(_content.size()):
		if _content[i] == null:
			_content[i] = null  # Remplissage propre

# Ajoute un objet à l'inventaire
func add_item(item: Item) -> bool:
	for i in range(_content.size()):
		if _content[i] == null:  # Vérification correcte
			_content[i] = item
			print("✅ Objet ajouté :", item.name)
			return true
	print("⚠️ Inventaire plein ! Impossible d'ajouter :", item.name)
	return false

# Supprime un objet
func remove_item(item: Item) -> bool:
	for i in range(_content.size()):
		if _content[i] == item:
			_content[i] = null
			print("🗑️ Objet retiré :", item.name)
			return true
	print("⚠️ L'objet n'est pas dans l'inventaire !")
	return false

# Retourne tous les objets non nuls
func get_items() -> Array[Item]:
	return _content.filter(func(i): return i != null)

# Augmente la taille de l'inventaire
func increase_inventory_size(amount: int):
	if amount > 0:
		_max_size += amount
		resize_inventory()
		print("🎒 Inventaire agrandi à", _max_size, "emplacements.")
	else:
		print("⚠️ Impossible de réduire la taille de l'inventaire !")
