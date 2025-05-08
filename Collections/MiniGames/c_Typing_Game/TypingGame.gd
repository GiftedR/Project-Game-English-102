extends MiniGames
class_name TypingGame

static var score:int = 0

@onready var world:Node2D = $nde2_World
@onready var lbl2_scorebox:Label = $cmr2_Game_Camera/lbl2_Score
const type_bubble:PackedScene = preload("res://Collections/MiniGames/c_Typing_Game/p_Type.tscn")

var upcoming_typings:Array[TypeChallenge] = []

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if !is_active: return
	if upcoming_typings == null || upcoming_typings.size() < 1:
		upcoming_typings.append(type_bubble.instantiate())
		world.add_child.call_deferred(upcoming_typings[0])
	elif !is_instance_valid(upcoming_typings[0]):
		upcoming_typings.pop_front()
	
	lbl2_scorebox.text = "Score: %s" % score

func _input(event: InputEvent) -> void:
	if is_active && event is InputEventKey && !event.is_pressed():
		if upcoming_typings != null && upcoming_typings.size() > 0 && is_instance_valid(upcoming_typings[0]):
			upcoming_typings[0].check_character(OS.get_keycode_string(event.key_label))
		
