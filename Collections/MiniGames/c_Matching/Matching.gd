extends MiniGames
class_name Matching

static var score:int = 0

static var instance:Matching
var locked:bool = false

var selected_cards:Array[Card] = []

@onready var nde2_Board:Node2D = $nde2_Board

func _ready() -> void:
	instance = self

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if !is_active: return

	if nde2_Board.get_child_count() == 0:
		_spawn_board(5)
	$Camera2D/lbl2_score.text = str(score)
	if selected_cards == null:
		selected_cards = []
	if selected_cards.size() < 2:
		return
	if selected_cards[0].savedCharacter == selected_cards[1].savedCharacter:
		score += 1
		selected_cards[0].do_match()
		selected_cards[1].do_match()
		selected_cards = []
	elif selected_cards.size() == 2:
		locked = true
		await get_tree().create_timer(1).timeout
		if selected_cards.size() > 0: selected_cards[0].flipped = false
		if selected_cards.size() > 1: selected_cards[1].flipped = false
		selected_cards = []
		locked = false

func _spawn_board(size:int) -> void:
	for x:int in size:
		for y:int in size:
			nde2_Board.add_child.call_deferred(
				Card.spawn_card(
					Vector2i(
						((x * 128) - (size * 128) / 2.0 as int) + 64,
					 	((y * 128) - (size * 128) / 2.0 as int) + 64
					)
				)
			)
