extends Node2D
class_name MiniGames

static var is_active:bool = false

func _physics_process(_delta: float) -> void:
	is_active = is_visible_in_tree()