extends MiniGames
class_name TypingGame

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if !is_active: return

