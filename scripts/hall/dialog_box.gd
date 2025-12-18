extends Control
class_name Dialogue

signal on_dialog_end

var dialog : Array = ["Bienvenue à Concordia !"]

var saison_dialogue = [
	"Nous sommes rentré en pleine saison d'été.\nN'oublie pas qu'il fait donc tout le temps jour.",
	"Nous sommes rentré en pleine saison d'hiver.\nN'oublie pas qu'il fait donc tout le temps nuit."
]

var saison = 0
var dialog_index = 0
var finished = false
@onready var label : RichTextLabel = $richTextLabel

func set_saison(s : int):
	saison = s

func set_dialog(dialogue : Array) :
	dialog = dialogue.duplicate()
	dialog.push_back(saison_dialogue[saison])
	dialog_index = 0

func _ready() -> void:
	load_dialog()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

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
