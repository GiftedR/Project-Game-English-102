extends Node2D
class_name EntityController

var max_speed:float = 50
var acceleration:float = max_speed * 4

var move_direction:Vector2 = Vector2.ZERO

func with_name(newname:String) -> EntityController:
	name = newname
	return self