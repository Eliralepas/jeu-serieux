extends Control
class_name Dialogue

signal on_dialog_end

var dialog : Array = ["..."]

var saison_dialogue = [
	"Nous sommes rentrés en pleine saison d'été.\nN'oublie pas qu'il fait tout le temps jour.",
	"Nous sommes rentrés en pleine saison d'hiver.\nN'oublie pas qu'il fait tout le temps nuit.",
	""
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


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		load_dialog()
