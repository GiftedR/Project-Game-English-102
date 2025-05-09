extends Area2D
class_name Card

@onready var lbl2_card:Label = $PanelContainer/lbl2_Card

var flipped:bool = false
var is_hovered:bool = false
var savedCharacter:String = "0"
var starting_location:Vector2i = Vector2i.ZERO


const card_path:PackedScene = preload("res://Collections/MiniGames/c_Matching/p_Match_Card.tscn")

static func spawn_card(startinglocation:Vector2i) -> Card:
	return card_path.instantiate()\
		.with_character(RandomUtils.random_character())\
		.with_starting_location(startinglocation)

func _ready() -> void:
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)
	position = starting_location

func _physics_process(_delta: float) -> void:
	lbl2_card.text = savedCharacter
	$PanelContainer.visible = flipped

func with_character(character:String) -> Card:
	savedCharacter = character
	return self

func _mouse_entered() -> void:
	is_hovered = true

func _mouse_exited() -> void:
	is_hovered = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && \
		event.button_index == 1 && \
		event.is_pressed() && \
		is_hovered &&\
		!Matching.instance.locked && \
		flipped == false:
		flipped = true
		Matching.instance.selected_cards.append(self)

func do_match() -> void:
	Matching.instance.nde2_Board.add_child.call_deferred(spawn_card(starting_location))
	queue_free()

func with_starting_location(startinglocation:Vector2i) -> Card:
	starting_location = startinglocation
	return self