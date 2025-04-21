extends Entity
class_name Player

static var instance:Player
@onready var interact_screen_sprite:Sprite2D = $cvl2_Active_Controls/ctr2_Active_Controls/vbc2_Controls/hbc2_Controls/ctr2_Interact_Button/spe2_Interact_Button
@onready var move_screen_sprite:Sprite2D = $cvl2_Active_Controls/ctr2_Active_Controls/vbc2_Controls/hbc2_Controls/ctr2_Move_Buttons/spe2_Move_Buttons

func _init() -> void:
	instance = self

func _enter_tree() -> void:
	if _controller == null:
		_controller = PlayerController.new()\
			.with_name("Player Controller")
	super._enter_tree()

#region Prefabs

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _controller is PlayerController:
		interact_screen_sprite.frame_coords = Vector2(2, 0 if _controller.is_controller else 1)
		move_screen_sprite.region_rect = Rect2(Vector2(80.0, 0 if _controller.is_controller else 16), Vector2(64, 16))

static func spawn() -> Entity:
	return load("res://Pieces/p_Player.tscn")\
		.instantiate()\
		.with_name("Spawned Player")

#endregion

#region Builder



#endregion