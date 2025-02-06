extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label

func display(item: Item):
	if item and item.icon:
		texture_rect.texture = item.icon
		label.text = item.name
	else:
		print_debug("⚠️ L'item ou son icône est null !")
