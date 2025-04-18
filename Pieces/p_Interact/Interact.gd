extends Area2D
class_name Interact

@export var call_action:Callable = func() -> void: ActionBoard.spawn()
@export var is_interactable:bool = true
@export var is_important:bool = true

func _ready() -> void:
	mouse_entered.connect(
		func() -> void: 
			if is_interactable:
				$spe2_Interact.visible = true
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			$asp2_Interact.visible = is_interactable && is_important
	)
	mouse_exited.connect(
		func() -> void: 
			$spe2_Interact.visible = false
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			$asp2_Interact.visible = is_interactable && is_important
	)
	input_event.connect(
		func(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
			if event is InputEventMouseButton\
				&& event.button_index == 1\
				&& event.is_pressed() == false\
				&& event.is_canceled() == false\
				&& call_action.is_valid():
				call_action.call()
	)
	$spe2_Interact.visible = false
