extends EntityController
class_name PlayerController

static var instance:PlayerController

var camera:Camera2D = Camera2D.new()
var is_controller:bool = false
var camera_zoom:float = 4

const tp_locations:Array[Vector2i] = [
	Vector2i(0, -850), # Works Cited
	Vector2i(50, 394), # Intro
	Vector2i(0, 64), # Thesis
	Vector2i(-145, -177), # Arg 1
	Vector2i(145, -177), # Arg 2
	Vector2i(-145, -400), # Arg 3
	Vector2i(145, -400), # Arg 4
	Vector2i(0, -545) # Conc
]

func _init() -> void:
	instance = self

func _enter_tree() -> void:
	add_child(camera)

func _ready() -> void:
	camera.make_current()
	call_deferred("_set_camera_limits")
	ActionControls.instance.modify_zoom.connect(func(val:float) -> void:
		if val != 0:
			camera_zoom += val
		else:
			camera_zoom = 4
	)

func _physics_process(_delta: float) -> void:
	move_direction = Input.get_vector("ply_left", "ply_right", "ply_up", "ply_down")
	is_sprinting = Input.get_action_strength("ply_sprint") > 0
	is_interacting = Input.get_action_strength("ply_Interact") > 0
	camera.zoom = Vector2(camera_zoom, camera_zoom) if camera_zoom != 0 else Vector2.ONE

func _set_camera_limits() -> void:
	camera.limit_top = World.instance.t_limit
	camera.limit_right = World.instance.r_limit
	camera.limit_bottom = World.instance.b_limit
	camera.limit_left = World.instance.l_limit

func _input(event: InputEvent) -> void:
	if MiniGames.is_active:
		return
	if event is InputEventKey || event is InputEventMouseMotion || event is InputEventMouseMotion:
		is_controller = false
	elif event is InputEventJoypadButton || event is InputEventJoypadMotion:
		is_controller = true
	
	if event is InputEventKey:
		match event.key_label:
			KEY_8:
				Player.instance.position = tp_locations[0]
			KEY_1:
				Player.instance.position = tp_locations[1]
			KEY_2:
				Player.instance.position = tp_locations[2]
			KEY_3:
				Player.instance.position = tp_locations[3]
			KEY_4:
				Player.instance.position = tp_locations[4]
			KEY_5:
				Player.instance.position = tp_locations[5]
			KEY_6:
				Player.instance.position = tp_locations[6]
			KEY_7:
				Player.instance.position = tp_locations[7]
