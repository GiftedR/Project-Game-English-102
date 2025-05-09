extends Node2D
class_name TypeChallenge

@onready var panelCon:PanelContainer = $plc2_Characters

var characters_to_type:Array[CharacterLabel] = []

func _ready() -> void:
	generate_typing(3 + floori(TypingGame.score as float / 10))

func generate_typing(length:float = 3) -> void:
	for i:int in length:
		_create_label.call_deferred(RandomUtils.random_character(), i)

func _create_label(character:String, location:int = 0) -> CharacterLabel:
	var returnLabel:CharacterLabel = CharacterLabel.new(character, location)
	characters_to_type.append(returnLabel)
	panelCon.add_child(returnLabel)

	return returnLabel

func check_character(character:String) -> bool:
	for cl:CharacterLabel in characters_to_type:
		if !cl.is_complete && cl.is_correct_character(character):
			if cl == characters_to_type[-1]:
				complete_type()
			return true
		elif !cl.is_complete:
			return false
	if characters_to_type == null || characters_to_type.size() == 0:
		return false
	else:
		complete_type()
		return true

func complete_type() -> void:
	TypingGame.score += 1
	queue_free()

class CharacterLabel extends Label:
	var is_complete:bool = false
	var is_mistyped:bool = false
	var saved_character:String = ""
	const font_location:Font = preload("res://Pieces/Fonts.png")
	
	func _init(character:String = "0", location:int = 0) -> void:
		var ls:LabelSettings = LabelSettings.new()
		var labelText:String = ""

		name = "Character: %s" % character

		saved_character = character
		
		ls.font_size = 48
		ls.font_color = Color.WHITE
		ls.font = font_location

		label_settings = ls
		
		for i:int in location:
			labelText += " "
		labelText += character

		text = labelText

		texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	func _physics_process(_delta: float) -> void:
		if is_complete:
			self_modulate = Color.from_string("7ffc7f", Color.GREEN)
		elif !is_complete && is_mistyped:
			self_modulate = Color.from_string("fc7f7f", Color.RED)
		else:
			self_modulate = Color.from_string("ffffff", Color.WHITE)

	func is_correct_character(character:String) -> bool:
		if saved_character.to_upper() == character.to_upper():
			is_complete = true
			return true
		is_complete = false
		is_mistyped = true
		return false