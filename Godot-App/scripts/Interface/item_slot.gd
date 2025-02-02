extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect

func display(item: Item):
	if item and item.icon:
		texture_rect.texture = item.icon
	else:
		print_debug("⚠️ L'item ou son icône est null !")
