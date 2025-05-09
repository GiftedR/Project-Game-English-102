extends MiniGames
class_name Blockle

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if !is_active: return