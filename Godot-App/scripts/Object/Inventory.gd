class_name Inventory

var _max_size: int = 1
var _content: Array[Item] = []

func _init():
	_content.resize(_max_size)

func add_item(item: Item) -> bool:
	# Vérifier s'il y a une place libre dans l'inventaire
	for i in range(_content.size()):
		if _content[i] == null:
			_content[i] = item
			GameInteraction.can_drop()
			print("✅ Objet ajouté :", item.name)
			return true
	print("❌ L'inventaire est plein !")
	return false

func remove_item(item: Item) -> bool:
	if item in _content:
		_content.erase(item)
		print("🗑️ Objet retiré :", item.name)
		return true
	print("⚠️ L'objet n'est pas dans l'inventaire !")
	return false

func get_items() -> Array[Item]:
	# Retourner seulement les objets non-nuls
	return _content.filter(func(i): return i != null)

func increase_inventory_size(amount: int):
	if amount > 0:
		_max_size += amount
		_content.resize(_max_size)
		print("🎒 Inventaire agrandi à", _max_size, "emplacements.")
	else:
		print("⚠️ Impossible de réduire la taille de l'inventaire !")
