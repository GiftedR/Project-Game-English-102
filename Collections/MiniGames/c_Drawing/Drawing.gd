extends MiniGames
class_name Drawing

var active_tile:Vector2i = Vector2i.RIGHT

@onready var tile:TileMapLayer = $tml2_Drawing
@onready var sample:Sprite2D = %spe2_Sample

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if !is_active: return
	print("DRAW!")
	if active_tile.x > 7:
		active_tile.x = 0
		active_tile.y += 1
	elif active_tile.x < 0:
		active_tile.y = 7
		active_tile.y -= 1
	if active_tile.y > 7:
		active_tile.y = 0
	elif active_tile.y < 0:
		active_tile.y = 7
	sample.frame_coords = active_tile
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		tile.set_cell(Vector2i(get_global_mouse_position()), 0, active_tile)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		tile.set_cell(Vector2i(get_global_mouse_position()), -1, active_tile)

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.keycode == KEY_BRACKETRIGHT && event.is_pressed() == false:
		active_tile.x += 1
	if event is InputEventKey && event.keycode == KEY_BRACKETLEFT && event.is_pressed() == false:
		active_tile.x += 1
