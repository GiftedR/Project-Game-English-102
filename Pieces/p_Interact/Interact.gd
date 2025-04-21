extends Area2D
class_name Interact

@export var call_action:Callable = func() -> void: ActionBoard.spawn()
@export var is_interactable:bool = true
@export var is_important:bool = true

var is_mouse_inside:bool = false

func _ready() -> void:
	mouse_entered.connect( func() -> void:
		show_interact()
		is_mouse_inside = true
	)
	mouse_exited.connect( func() -> void:
		hide_interact()
		is_mouse_inside = false
	)
	input_event.connect(
		func(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
			if event is InputEventMouseButton\
				&& event.button_index == 1\
				&& event.is_pressed() == false\
				&& event.is_canceled() == false:
					open_action()
	)
	$spe2_Interact.visible = false

func _physics_process(_delta: float) -> void:
	var areas:Array[Area2D] = get_overlapping_areas()

	if !is_mouse_inside && areas.size() == 0:
		hide_interact()

	for a:Area2D in areas:
		if a.get_collision_layer_value(32):
			show_interact()

func show_interact() -> void:
	if is_interactable:
		$spe2_Interact.visible = true
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	$asp2_Interact.visible = is_interactable && is_important

func hide_interact() -> void:
	$spe2_Interact.visible = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	$asp2_Interact.visible = is_interactable && is_important

func open_action() -> void:
	if call_action.is_valid():
		call_action.call()