extends "res://scripts/piece_abstraite.gd"

@onready var store:= $Store

var budget = 500 #A changer, sera en fct du json

@onready var porte:= $songs/porte
# On crée un dictionnaire reliant le nom du bouton au node correspondant
#on met tous les objets possibles, meme si on les a pas encore achete
@onready var objects := {
	"Checkpouf": $Assets/Stuff/Pouf,
	"Checkcommode":$Assets/Rangement/Commode,
	"Checkarmoire": $Assets/Rangement/Armoire2,
	"Checkcoffre": $Assets/Rangement/Coffre,
	"Checktabouret": $Assets/Stuff/Tabouret,
	"Checktapis": $Assets/Tapis/GrandTapis,
	"Checkplant": $Assets/Plantes/Plant,
	"Checkplante": $Assets/Plantes/Plante,
	"Checklampe": $Assets/Stuff/Lampe,
	"Checkechelle": $Assets/Stuff/Echelle,
	"Checkcadres":$Assets/Stuff/Cadres
}


var stock = []

func _ready():
	clear_check_boxes()
	add_check_box()
	connect_the_check_box()
	
	$Menu/Panel/Label.text = str(budget) #cast int en str

	

	
	
	$Menu/Panel.connect("magasin_pressed", Callable(self, "_on_magasin_pressed"))
	$Menu/Panel.connect("finaliser_pressed", Callable(self, "_on_finaliser_pressed"))
	
	$MenuMurColor.get_popup().connect("id_pressed", Callable(self, "_on_mur_color_selected"))
	
	
func add_check_box()->void:
	for item in stock:
		var check = CheckButton.new()
		check.name="Check"+item
		check.text=item
		##############
		check.add_theme_color_override("font_color", Color(0.0, 0.0, 0.5))           # Normal
		check.add_theme_color_override("font_color_pressed", Color(0.0, 0.0, 0.5))   # When pressed
		check.add_theme_color_override("font_color_hover", Color(0.0, 0.0, 0.5))     # When hovered
		check.add_theme_color_override("font_color_focus", Color(0.0, 0.0, 0.5))
		##############
		check.add_theme_font_size_override("font_size", 30)
		
		#lorsqu'on fini d'acheter le boutons deja coche le restera 
		var target = objects.get(check.name)
		if target and target.visible:
			check.button_pressed = true

		$Menu/GrilleCheckBox.add_child(check)
		
func clear_check_boxes() -> void:
	for child in $Menu/GrilleCheckBox.get_children():
		child.queue_free()
	
func connect_the_check_box()->void:
	for button_name in objects.keys():
		var button_path = "Menu/GrilleCheckBox/%s" % button_name  # crée le chemin en texte
		if has_node(button_path):  # vérifie que le bouton existe
			var button = get_node(button_path)
			button.connect("toggled", Callable(self, "_on_any_check_toggled").bind(button_name))
	

func _on_any_check_toggled(toggled_on: bool, button_name: String) -> void:
	var target = objects.get(button_name) #recup objet emeteur du signal
	if target:
		target.visible = toggled_on #on met la visibilite selon comment est l'etant du btn clicke


func _on_magasin_pressed() -> void: #lors du clique sur le btn magasin
	porte.play() #bruitage
	await get_tree().create_timer(1.20).timeout #petit time de pause
		#gestions des sons
	$songs/magasinBackground.play() 
	$songs/talkingPeople.play()
	$songs/mainBackground.stop()
	
	store.decoche_tout() #on decoche toutes les cases du magasin
	

	store.stock = stock #on synchronise le stock du magasin avec celui de la piece
	store.visible=true; #on met le magasin en mode visible
	


func _on_finaliser_pressed() -> void:
	#on genereras un json
	get_tree().change_scene_to_file("res://scenes/piece_princiaple.tscn") #retour a la piece principale




	#fonction pure test , A SUPRIMER UNE FOIS QUE LE MAGASIN MARCHE POUR TOUS
func _on_visualise_stock_pressed() -> void:
	prints("///////////////")
	lire_stock(stock)


	#modification de la couleur des mur
func _on_menu_mur_color_pressed() -> void:
	var menuMur = $MenuMurColor
	menuMur.get_popup().clear() #afin de ne pas repeter les item a chaque clique
	menuMur.get_popup().add_item("bleu",0)
	menuMur.get_popup().add_item("rouge",1)
	menuMur.get_popup().add_item("vert",2)
	
func _on_mur_color_selected(id: int) -> void:
	couleur_mur(id) 

	
func couleur_mur(num : int) -> void: 
	var bleu=$Mur_Couleurs/Mur_Bleu
	var rouge=$Mur_Couleurs/Mur_Rouge
	var vert=$Mur_Couleurs/Mur_Vert

	match num:
		0:
			bleu.visible=true
			rouge.visible=false
			vert.visible=false
		1 :
			bleu.visible=false
			rouge.visible=true
			vert.visible=false
		2:
			bleu.visible=false
			rouge.visible=false
			vert.visible=true
