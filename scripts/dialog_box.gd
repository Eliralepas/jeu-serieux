extends Control

signal on_dialog_end

var dialog = [
	"Hello there",
	"OOO MY GODDDDD",
	"YAY, I am a patato and im gonna ezat you human"
]

var dialog_index = 0
var finished = false
@onready var label : RichTextLabel = $RichTextLabel


func _ready() -> void:
	load_dialog()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
	
func load_dialog():
	if dialog_index<dialog.size():
		var tween : Tween = create_tween()
		label.text = dialog[dialog_index]
		label.visible_ratio = 0
		tween.tween_property(label, "visible_ratio", 1, 1.5)
		
	else :
		queue_free()
		on_dialog_end.emit()
	dialog_index+=1
