extends CanvasLayer
class_name ActionBoard

@onready var btn2_Cancel:Button = $ctr2_Action_Board/mgc2_Actions/vbc2_Actions/hbc2_Window_Controls/btn2_Cancel
@onready var btn2_Confirm:Button = $ctr2_Action_Board/mgc2_Actions/vbc2_Actions/hbc2_Window_Controls/btn2_Confirm

@onready var btn2_full_text:Button = $ctr2_Action_Board/mgc2_Actions/vbc2_Actions/hbc2_Window_Controls/btn2_Full_Text

@onready var action_panel:PanelContainer = $ctr2_Action_Board/mgc2_Actions/vbc2_Actions/plc2_Actions
@onready var text_panel:PanelContainer = $ctr2_Action_Board/mgc2_Actions/vbc2_Actions/plc2_Full_Text

var is_full_text_visible:bool = false

static func spawn() -> ActionBoard:
	var board:ActionBoard = load("res://Pieces/p_Action_Board.tscn").instantiate()
	World.instance.get_viewport().get_camera_2d().add_child(board)
	return board

func _ready() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	btn2_Cancel.pressed.connect(func() -> void: self.queue_free())
	btn2_full_text.pressed.connect(func() -> void:
		is_full_text_visible = !is_full_text_visible

		action_panel.visible = !is_full_text_visible
		text_panel.visible = is_full_text_visible
	)


func _enter_tree() -> void:
	Player.instance.with_busy()

func _exit_tree() -> void:
	Player.instance.with_busy(false)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.queue_free()
	
