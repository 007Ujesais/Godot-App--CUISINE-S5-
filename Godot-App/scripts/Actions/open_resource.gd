extends Node

var _source:Source = null

func execute(object_node:Node3D, panel:PanelContainer):
	if object_node and panel:
		if object_node is interactive_object and panel is ActionSlot:
			if object_node.object is Source:
				_source = object_node.object
				
				GameManager.player.curent_source = _source
				
				InterfaceManager.open_resource_dialog()
				
