class_name ItemSlot
extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: Label = %LabelName
@onready var label_quantity: Label = %LabelQuantity
@onready var button: Button = %Button

var _item: Item = null

func _ready() -> void:
	button.hide()

func display(item: Item):
	button.hide()
	if item and item.icon:
		_item = item
		texture_rect.texture = _item.icon
		label_name.text = _item.name
		label_quantity.text = "01"
	else:
		print_debug("⚠️ L'item ou son icône est null !")

func display_with_add_button(item: Item):
	button.show()
	if item and item.icon:
		_item = item
		texture_rect.texture = _item.icon
		label_name.text = _item.name
		label_quantity.text = "01"
	else:
		print_debug("⚠️ L'item ou son icône est null !")

func _on_button_pressed():
	if _item:
		if GameManager.player.inventory.add_item(_item):
			GameManager.player.curent_source._content.remove_item(_item)
			InterfaceManager.open_resource_dialog()
	else:
		print_debug("⚠️ Impossible d'ajouter un item null !")
