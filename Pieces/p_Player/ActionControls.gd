extends Control
class_name ActionControls

static var instance:ActionControls

func _init() -> void:
	instance = self

@onready var btn_zoom_in:Button = $vbc2_Controls/hbc2_Zoom/btn2_Zoom_In
@onready var btn_zoom_reset:Button = $vbc2_Controls/hbc2_Zoom/btn2_Zoom_Reset
@onready var btn_zoom_out:Button = $vbc2_Controls/hbc2_Zoom/btn2_Zoom_Out

signal modify_zoom(value:float)

func _ready() -> void:
	btn_zoom_in.button_up.connect(func() -> void: _zoom_in())
	btn_zoom_reset.button_up.connect(func() -> void: _zoom_reset())
	btn_zoom_out.button_up.connect(func() -> void: _zoom_reset())


func _physics_process(_delta: float) -> void:
	set_deferred("size", DisplayServer.window_get_size(0) / 4)
	position = Vector2.ZERO

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ply_zm_in"):
		_zoom_in()
	if Input.is_action_just_pressed("ply_zm_out"):
		_zoom_out()
	if Input.is_action_just_pressed("ply_zm_reset"):
		_zoom_reset()

func _zoom_in() -> void:
	modify_zoom.emit(1)

func _zoom_out() -> void:
	modify_zoom.emit(-1)

func _zoom_reset() -> void:
	modify_zoom.emit(0)