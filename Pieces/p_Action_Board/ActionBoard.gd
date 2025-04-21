extends CanvasLayer
class_name ActionBoard

@onready var btn2_Cancel:Button = $ctr2_Action_Board/mgc2_Actions/VBoxContainer/hbc2_Window_Controls/btn2_Cancel
@onready var btn2_Confirm:Button = $ctr2_Action_Board/mgc2_Actions/VBoxContainer/hbc2_Window_Controls/btn2_Confirm

static func spawn() -> ActionBoard:
	var board:ActionBoard = load("res://Pieces/p_Action_Board.tscn").instantiate()
	World.instance.get_viewport().get_camera_2d().add_child(board)
	return board

func _ready() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	btn2_Cancel.pressed.connect(func() -> void: self.queue_free())

func _enter_tree() -> void:
	Player.instance.with_busy()

func _exit_tree() -> void:
	Player.instance.with_busy(false)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.queue_free()
	
