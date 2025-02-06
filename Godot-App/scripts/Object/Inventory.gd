class_name Inventory

var _max_size: int = 4
var _content: Array[Item] = []

func _init():
	_content.resize(_max_size)

func add_item(item: Item):
	for i in range(_content.size()):
		if _content[i] == null:
			_content[i] = item
			GameInteraction.can_drop()
			return
	print("L'inventaire est plein !")

func remove_item(item:Item):
	_content.erase(item)

func get_items() -> Array[Item]:
	return _content

func increase_inventory_size(amount: int):
	_max_size += amount
	_content.resize(_max_size)  # Agrandit l'inventaire
