extends CharacterBody2D
class_name Entity

var _controller:EntityController

@onready var animation_tree:AnimationTree = $nde_Animations/ant_Entity
@onready var _charSprite:Sprite2D = $spe2_Entity
@onready var entityInteract:Area2D = $ara2_Interact

const skins:Array[String] = [
	"res://Pieces/p_Entity/Adam/Adam_16x16.png",
	"res://Pieces/p_Entity/Alex/Alex_16x16.png",
	"res://Pieces/p_Entity/Amelia/Amelia_16x16.png",
	"res://Pieces/p_Entity/Bob/Bob_16x16.png"
]

var starting_location:Vector2 = Vector2.ZERO

var current_skin:int = 0
var set_skin:int = 0

var _spawned_type_name:String = "Entity"
var _name:String = ""

func _enter_tree() -> void:
	print("Ent Called")
	if _controller == null:
		_controller = EntityController.new()\
			.with_name("Default Controller")
	
	add_child(_controller)

func _ready() -> void:
	position = starting_location

func _physics_process(delta: float) -> void:
	if _controller.is_busy:
		return
	velocity = velocity.move_toward(
		_controller.move_direction * _controller.max_speed * (2 if _controller.is_sprinting else 1), 
		delta * _controller.acceleration
	)

	if set_skin != current_skin:
		_charSprite.texture = load(skins[set_skin])
		current_skin = set_skin

	if _controller.move_direction != Vector2.ZERO:
		entityInteract.rotation_degrees = rad_to_deg(Vector2.ZERO.angle_to_point(_controller.move_direction)) + 90
		animation_tree.set("parameters/conditions/is_walking", true)
		animation_tree.set("parameters/conditions/is_idle", false)
		animation_tree.set("parameters/Idle/blend_position", _controller.move_direction)
		animation_tree.set("parameters/Walk/blend_position", _controller.move_direction)
	else:
		animation_tree.set("parameters/conditions/is_walking", false)
		animation_tree.set("parameters/conditions/is_idle", true)
	
	if _controller.is_interacting:
		for a:Area2D in entityInteract.get_overlapping_areas():
			if a is Interact:
				a.open_action()

	move_and_slide()

#region Prefabs

static func spawn() -> Entity:
	return load("res://Pieces/p_Entity.tscn").instantiate().with_name("Spawned Entity")

static func Adam() -> Entity:
	return spawn().with_character("Adam")
static func Alex() -> Entity:
	return spawn().with_character("Alex")
static func Amelia() -> Entity:
	return spawn().with_character("Amelia")
static func Bob() -> Entity:
	return spawn().with_character("Bob")

#endregion

#region Builder

func with_busy(isbusy:bool = true) -> Entity:
	_controller.is_busy = isbusy
	return self

func with_character(charactername:String) -> Entity:
	return self.with_skin(charactername).with_character_name(charactername)

func with_controller(controller:EntityController) -> Entity:
	_controller = controller
	return self

func with_name(newname:String) -> Entity:
	if "Spawned" in newname:
		_spawned_type_name = newname.split(" ", false, 1)[1]
	name = newname
	_name = newname
	return self

func with_name_addition(addition:String) -> Entity:
	name += addition
	_name = name
	return self

func with_starting_location(location:Vector2) -> Entity:
	starting_location = location
	return self

func with_skin(skinname:String = "Adam") -> Entity:
	match skinname:
		"Adam":
			set_skin = 0
		"Alex":
			set_skin = 1
		"Amelia":
			set_skin = 2
		"Bob":
			set_skin = 3

	return self

func with_character_name(charactername:String) -> Entity:
	name = _name + " (" + charactername + ")"
	return self
#endregion