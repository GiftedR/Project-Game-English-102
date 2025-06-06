extends Control
class_name ActionBoard

@onready var btn2_Cancel:Button = $mgc2_Actions/vbc2_Actions/hbc2_Window_Controls/btn2_Cancel
@onready var btn2_Confirm:Button = $mgc2_Actions/vbc2_Actions/hbc2_Window_Controls/btn2_Confirm
@onready var btn2_full_text:Button = $mgc2_Actions/vbc2_Actions/hbc2_Window_Controls/btn2_Full_Text

@onready var action_panel:PanelContainer = $mgc2_Actions/vbc2_Actions/plc2_Actions
@onready var text_panel:PanelContainer = $mgc2_Actions/vbc2_Actions/plc2_Full_Text

@onready var rtl_full_text:MarkdownLabel = %rtl2_Full_Text

@onready var lbl_action_title:Label = $mgc2_Actions/vbc2_Actions/lbl2_Action_Title

@onready var svp_mini_game:SubViewport = $mgc2_Actions/vbc2_Actions/plc2_Actions/svc2_Mini_Game/svp_Mini_Game

var action_game:Node2D

@export var is_full_text_visible:bool = true
@export var full_text_only:bool = false
@export var title_text:String = "Action Title (:"
@export_multiline var full_text_content:String = "According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyway because bees don't care what humans think is impossible. Yellow, black. Yellow, black. Yellow, black. Yellow, black. Ooh, black and yellow! Let's shake it up a little Barry! Breakfast is ready! Coming! Hang on a second. Hello? Barry? Adam? Can you believe this is happening? I can't. I'll pick you up. Looking sharp. Use the stairs, Your father paid good money for those. Sorry. I'm excited. Here's the graduate. We're very proud of you, son. A perfect report card, all B's. Very proud. Ma! I got a thing going here. You got lint on your fuzz. Ow! That's me!"
@export var action_scene:PackedScene

static func spawn() -> ActionBoard:
	var board:ActionBoard = load("res://Pieces/p_Action_Board.tscn").instantiate()
	Root.add_menu(board)
	return board

func _ready() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	btn2_Cancel.pressed.connect(func() -> void: self.queue_free())
	btn2_full_text.toggled.connect(func(toggled:bool) -> void:
		is_full_text_visible = !toggled

		action_panel.visible = !is_full_text_visible
		text_panel.visible = is_full_text_visible
	)

	call_deferred("_update_properties")

func _update_texts() -> void:
	rtl_full_text.markdown_text = full_text_content
	lbl_action_title.text = title_text
	btn2_full_text.visible = !full_text_only
	# btn2_Confirm.visible = !full_text_only
	if full_text_only:
		is_full_text_visible = true
	action_panel.visible = !is_full_text_visible
	text_panel.visible = is_full_text_visible
	btn2_Cancel.text = "Close"
	
func _update_properties() -> void:
	_update_texts()
	if action_scene != null:
		action_game = action_scene.instantiate()
		svp_mini_game.add_child.call_deferred(action_game)

func _enter_tree() -> void:
	Player.instance.with_busy()

func _exit_tree() -> void:
	Player.instance.with_busy(false)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.queue_free()
	
func with_title(title:String) -> ActionBoard:
	title_text = title
	_update_texts()
	return self

func with_content(content:String) -> ActionBoard:
	full_text_content = content
	_update_texts()
	return self

func with_full_text_only(fulltextonly:bool = true) -> ActionBoard:
	full_text_only = fulltextonly
	_update_texts()
	return self

func with_full_text_visible(fulltextvisible:bool = true) -> ActionBoard:
	is_full_text_visible = fulltextvisible
	return self

func with_game(game:PackedScene) -> ActionBoard:
	if game is PackedScene: action_scene = game
	return self
