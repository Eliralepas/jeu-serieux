extends Node2D

@onready var porte:= $song/clickButton
# On crée un dictionnaire reliant le nom du bouton au node correspondant
@onready var objects := {
	"CheckPouf": $Stuff/Pouf,
	"CheckArmoire": $Rangement/Armoire2,
	"CheckCoffre": $Rangement/Coffre,
	"CheckTabouret": $Stuff/Tabouret,
	"CheckTapis": $Tapis/GrandTapis,
	"CheckPlante1": $Plantes/Plant,
	"CheckPlante2": $Plantes/Plante,
	"CheckLampes": $Stuff/Lampe,
	"CheckEchelle": $Stuff/Echelle,
	"CheckCadres":$Stuff/Cadres
}

func _ready():
	for button_name in objects.keys():
		var button_path = "Menu/Checks/%s" % button_name  # crée le chemin en texte
		if has_node(button_path):  # vérifie que le bouton existe
			var button = get_node(button_path)
			button.connect("toggled", Callable(self, "_on_any_check_toggled").bind(button_name))

func _on_any_check_toggled(toggled_on: bool, button_name: String) -> void:
	var target = objects.get(button_name)
	if target:
		target.visible = toggled_on


func _on_button_magasin_pressed() -> void:
	porte.play()
	await get_tree().create_timer(1.20).timeout
	get_tree().change_scene_to_file("res://scenes/Magasin.tscn")
