extends Control

@onready var rich_text_label: RichTextLabel = $textureRect/richTextLabel
const PATH = "res://save/credit.txt"

func _ready() -> void:
	# On ouvre le fichier en lecture
	var file := FileAccess.open(PATH, FileAccess.READ)
	if file:
		var content := file.get_as_text()
		rich_text_label.text = content
	else:
		push_error("Impossible d'ouvrir le fichier : %s" % PATH)

func _on_button_pressed() -> void:
	visible = false
