extends CharacterBody2D
class_name Entity

static var entity_path:String = "res://Pieces/p_Entity.tscn"

var _controller:EntityController

#region Prefabs
#endregion

#region Builder

func with_controller(controller:EntityController) -> Entity:
    _controller = controller
    return self

#endregion