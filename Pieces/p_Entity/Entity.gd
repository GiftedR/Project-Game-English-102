extends CharacterBody2D
class_name Entity

var _controller:EntityController

@onready var entity_sprite:AnimatedSprite2D = $asp2_Entity

func _enter_tree() -> void:
	print("Ent Called")
	if _controller == null:
		_controller = EntityController.new()\
			.with_name("Default Controller")
	
	add_child(_controller)

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(
		_controller.move_direction * _controller.max_speed, 
		delta * _controller.acceleration
	)

	_rotate_sprite(_controller.move_direction)

	move_and_slide()

func _rotate_sprite(walkdirection:Vector2) -> void:
	var curranim:String = entity_sprite.animation
	const dirs:Array[Vector2] = [Vector2.UP, Vector2(0.9, 0), Vector2.DOWN, Vector2(-0.9, 0)]
	if walkdirection == Vector2.ZERO:
		if curranim.contains("_"):
			entity_sprite.play(curranim.split("_", false)[0])
		return
	
	match _get_closest(walkdirection, dirs):
		dirs[0]:
			entity_sprite.play("up_walk")
		dirs[1]:
			entity_sprite.play("right_walk")
		dirs[2]:
			entity_sprite.play("down_walk")
		dirs[3]:
			entity_sprite.play("left_walk")

func _get_closest(direction:Vector2, directions:Array[Vector2] = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.ZERO]) -> Vector2:
	var closestdir:Vector2 = Vector2.ZERO
	for dir:Vector2 in directions:
		if direction.distance_to(dir) < direction.distance_to(closestdir):
			closestdir = dir
	return closestdir

#region Prefabs

static func spawn() -> Entity:
	return load("res://Pieces/p_Entity.tscn").instantiate().with_name("Spawned Entity")

#endregion

#region Builder

func with_controller(controller:EntityController) -> Entity:
	_controller = controller
	return self

func with_name(newname:String) -> Entity:
	name = newname
	return self

#endregion