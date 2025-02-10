extends Node

var _basin:Basin = null

func execute(object_node:Node3D, panel:PanelContainer):
	if object_node and panel:
		if object_node is interactive_object and panel is ActionSlot:
			if object_node.object is Basin:
				_basin = object_node.object
				_basin.planel_ui = panel
				
				GameManager.player.curent_basin = _basin
				
				InterfaceManager.open_cooking_dialog()
				
