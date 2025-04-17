extends Node2D
class_name World

static var instance:World

@onready var top_left_limit:Node2D = $nde2_Cam_Limits/nde2_Top_Left
@onready var bottom_right_limit:Node2D = $nde2_Cam_Limits/nde2_Bottom_Right

@onready var t_limit:int: 
	get: 
		return top_left_limit.position.y as int
@onready var r_limit:int: 
	get: 
		return bottom_right_limit.position.x as int
@onready var b_limit:int: 
	get: 
		return bottom_right_limit.position.y as int
@onready var l_limit:int: 
	get: 
		return top_left_limit.position.x as int

func _init() -> void:
	instance = self

func _enter_tree() -> void:
	add_child(Player.spawn().with_character("Amelia"))

static func build() -> World:
	return load("res://Collections/c_World.tscn").instantiate()
