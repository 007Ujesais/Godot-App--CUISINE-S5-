class_name UIRoot
extends Control

@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var cooking_dialog: CookingDialog = %CookingDialog
@onready var resource_dialog: ResourceDialog = %ResourceDialog
@onready var ui_root: CanvasLayer = %UIRoot

func _ready():
	InterfaceManager.set_UIRoot(self)
