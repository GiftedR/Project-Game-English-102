extends Node
class_name Root

static var instance:Root

@onready var viewport:SubViewport = $cvl2_Gameplay/svc2_Gameplay/svp2_Gameplay
@onready var uiitems:Control = $cvl2_Gameplay/ctr2_Menus

func _init() -> void:
	instance = self

func _ready() -> void:
	viewport.add_child(World.build())

static func add_menu(menuitem:Control) -> void:
	instance.uiitems.add_child(menuitem)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_full"):
		match DisplayServer.window_get_mode():
			DisplayServer.WINDOW_MODE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			_: # DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)