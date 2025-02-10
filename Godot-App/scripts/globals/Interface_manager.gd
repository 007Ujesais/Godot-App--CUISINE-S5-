extends Node

var UIRoot: UIRoot = null

func set_UIRoot(UIRoot_node: UIRoot):
	UIRoot = UIRoot_node

func open_inventory_dialog():
	if UIRoot:
		UIRoot.inventory_dialog.open()
		UIRoot.cooking_dialog.hide()
		UIRoot.resource_dialog.hide()
		
		GameManager.player.set_camera_point_3()

func open_cooking_dialog():
	if UIRoot:
		UIRoot.inventory_dialog.hide()
		UIRoot.cooking_dialog.open()
		UIRoot.resource_dialog.hide()

		GameManager.player.set_camera_point_2()
		
func open_resource_dialog():
	if UIRoot:
		UIRoot.inventory_dialog.hide()
		UIRoot.cooking_dialog.hide()
		UIRoot.resource_dialog.open()

		GameManager.player.set_camera_point_2()

func close_dialog():
	if UIRoot:
		UIRoot.inventory_dialog.hide()
		UIRoot.cooking_dialog.hide()
		UIRoot.resource_dialog.hide()
		
		GameManager.player.set_camera_point_1()
