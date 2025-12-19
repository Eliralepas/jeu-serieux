## @class_doc
## @description Manages the display of dialogue sequences in a UI box.
## It handles the sequential text reveal using tweens and appends season-specific context messages.
## @tags ui, dialogue, narrative
extends Control
class_name Dialogue

signal on_dialog_end

var dialog : Array = ["..."]

## @var_doc
## @description A predefined list of season-specific messages to be appended to dialogues.
## Index 0 for Summer, 1 for Winter.
## @tags data, content, configuration
var saison_dialogue = [
	"Nous sommes rentrés en pleine saison d'été.\nN'oublie pas qu'il fait tout le temps jour.",
	"Nous sommes rentrés en pleine saison d'hiver.\nN'oublie pas qu'il fait tout le temps nuit.",
	""
]

var saison = 0
var dialog_index = 0
var finished = false
@onready var label : RichTextLabel = $richTextLabel

## @func_doc
## @description Sets the current season index to determine which context message to append.
## @param s: int The season index (0 for Summer, 1 for Winter).
## @tags configuration, setter
func set_saison(s : int):
	saison = s

## @func_doc
## @description Initializes the dialogue sequence with a new set of lines and resets the index.
## Appends the season-specific message to the end of the provided array.
## @param dialogue: Array The list of text strings to display.
## @tags initialization, logic
func set_dialog(dialogue : Array) :
	dialog = dialogue.duplicate()
	dialog.push_back(saison_dialogue[saison])
	dialog_index = 0

## @func_doc
## @description Called when the node enters the scene tree. Starts loading the first dialogue line.
## @tags life_cycle, initialization
func _ready() -> void:
	load_dialog()

## @func_doc
## @description Loads and displays the next line of dialogue.
## Uses a tween to animate the text appearance (`visible_ratio`).
## If there are no more lines, it frees the node and emits `on_dialog_end`.
## @tags logic, animation, ui
func load_dialog():
	if dialog_index<dialog.size():
		if dialog[dialog_index] != "" :
			var tween : Tween = create_tween()
			label.text = dialog[dialog_index]
			label.visible_ratio = 0
			tween.tween_property(label, "visible_ratio", 1, 1.5)	
	else :
		queue_free()
		on_dialog_end.emit()
	dialog_index+=1

## @func_doc
## @description Handles input on the texture rect to advance the dialogue when clicked.
## @param event: InputEvent The input event.
## @tags input_handling, ui
func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		load_dialog()
