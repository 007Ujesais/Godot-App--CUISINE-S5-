extends Node

var _basin:Basin = null

func execute(object_node:Node3D, panel:PanelContainer):
	if object_node and panel:
		if object_node is interactive_object and panel is ActionSlot:
			if object_node.object is Basin:
				_basin = object_node.object
				if panel.action_control is MenuAction and panel.action_control.button:
					if _basin.placed_ingredients:
						panel.hide_result()
						panel.show_action()
						_basin.get_placed_ingredients()
				
