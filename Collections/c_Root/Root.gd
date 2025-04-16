extends Node
class_name Root

func _enter_tree() -> void:
	add_child(World.build())
