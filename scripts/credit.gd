## @class_doc
## @description Displays the game credits loaded from a text file.
## @tags ui, info

## @depends FileAccess: uses Reads credit text from a file.
extends Control

## @onready_doc
## @description The RichTextLabel used to display the credit text.
## @tags nodes, ui
@onready var rich_text_label: RichTextLabel = $textureRect/richTextLabel

## @const_doc
## @description Path to the text file containing the credits.
## @tags config, data
const PATH = "res://save/credit.txt"

## @func_doc
## @description Loads the credit text from the file and sets it to the label on startup.
## @tags life_cycle, initialization, file_io
func _ready() -> void:
	# On ouvre le fichier en lecture
	var file := FileAccess.open(PATH, FileAccess.READ)
	if file:
		var content := file.get_as_text()
		rich_text_label.text = content
	else:
		push_error("Impossible d'ouvrir le fichier : %s" % PATH)

## @func_doc
## @description Hides the credits screen when the close button is pressed.
## @tags event_handler, ui
func _on_button_pressed() -> void:
	visible = false
