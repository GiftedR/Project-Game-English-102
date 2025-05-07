extends EntityController
class_name PlayerController

var camera:Camera2D = Camera2D.new()
var is_controller:bool = true
var camera_zoom:float = 4

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
	camera.zoom = Vector2(camera_zoom, camera_zoom)

func _set_camera_limits() -> void:
	camera.limit_top = World.instance.t_limit
	camera.limit_right = World.instance.r_limit
	camera.limit_bottom = World.instance.b_limit
	camera.limit_left = World.instance.l_limit

func _input(event: InputEvent) -> void:
	if event is InputEventKey || event is InputEventMouseMotion || event is InputEventMouseMotion:
		is_controller = false
	elif event is InputEventJoypadButton || event is InputEventJoypadMotion:
		is_controller = true
