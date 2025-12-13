extends Node2D
class_name Objet_casse

@onready var objet_casse: Button = $ObjetCasse
@onready var btn_reparer: Button = $ObjetCasse/BtnReparer

var repare : bool = false
var _cout : int = 120

func _ready() -> void:
	btn_reparer.text = "Réparer pour : " + str(_cout) + "$"

func est_repare() -> bool : 
	return repare

func set_repare() :
	repare = true

func _on_objet_casse_pressed() -> void:
	btn_reparer.visible = not btn_reparer.visible

func get_cout() -> int :
	return _cout
