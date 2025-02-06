extends Node

var pick:bool = false
var drop:bool = false


func can_drop():
	pick = false
	drop = true

func can_pick():
	pick = true
	drop = false
