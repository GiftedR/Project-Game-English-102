extends Entity
class_name Player

static var instance:Player

func _init() -> void:
	instance = self

func _enter_tree() -> void:
	if _controller == null:
		_controller = PlayerController.new()\
			.with_name("Player Controller")
	super._enter_tree()

#region Prefabs

static func spawn() -> Entity:
	return load("res://Pieces/p_Player.tscn")\
		.instantiate()\
		.with_name("Spawned Player")

#endregion

#region Builder



#endregion