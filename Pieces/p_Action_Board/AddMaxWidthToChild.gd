extends Control

@export var max_width:float = 640

func _physics_process(_delta: float) -> void:
	var child:CanvasItem = get_child(0)

	if child.size.x > max_width:
		child.size.x = max_width
		child.position.x = (size.x - max_width) / 2
