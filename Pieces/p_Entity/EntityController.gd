extends Node2D
class_name EntityController

var is_busy:bool = false

var max_speed:float = 50
var acceleration:float = max_speed * 8

var move_direction:Vector2 = Vector2.ZERO
var is_sprinting:bool = false

func with_name(newname:String) -> EntityController:
	name = newname
	return self