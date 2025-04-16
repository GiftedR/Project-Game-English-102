extends Node2D
class_name World

static func build() -> World:
	return load("res://Collections/c_World.tscn").instantiate()
