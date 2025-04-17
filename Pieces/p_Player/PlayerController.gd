extends EntityController
class_name PlayerController

var camera:Camera2D = Camera2D.new()

func _enter_tree() -> void:
	add_child(camera)

func _ready() -> void:
	camera.make_current()
	call_deferred("_set_camera_limits")

func _physics_process(_delta: float) -> void:
	move_direction = Input.get_vector("ply_left", "ply_right", "ply_up", "ply_down")
	# super._physics_process(delta)

func _set_camera_limits() -> void:
	camera.limit_top = World.instance.t_limit
	camera.limit_right = World.instance.r_limit
	camera.limit_bottom = World.instance.b_limit
	camera.limit_left = World.instance.l_limit