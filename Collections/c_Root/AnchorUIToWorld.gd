extends CanvasLayer

@export var anchor_position:Vector2 = Vector2i.ZERO

var _ply_cont:PlayerController:
	get: 
		return Player.instance._controller

func _physics_process(_delta: float) -> void:
	get_child(0).position = (-_ply_cont.camera.global_position + anchor_position) * _ply_cont.camera_zoom
