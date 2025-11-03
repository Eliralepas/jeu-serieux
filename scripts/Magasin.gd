#extends "res://scripts/grahics.gd"
extends Node2D

@onready var label = $Label
@onready var area = $Area2D
@onready var h_flow_container: HFlowContainer = $HFlowContainer

@onready var caisse:= $Songs/purchase



			#les differentes phrases
var dialogues = [
	"Qu'est-ce que tu veux ?",
	"Me dévalise pas ! Pas plus de deux articles.",
	"Accélère, j'ai d'autres clients !" # dernière phrase normale
]

		#objets du magasin
var objets = [
	"armoire", "cadres", "coffre", "commode", "grand_tapis", "lampe", "plant", "plante", "pouf"]


var index = 0 #pour avoir le nb de clicks sur le dialogue

#####################################################################################

func _ready(): #quand la scene demarre
	self.visible=true
	label.text = dialogues[index] #on met dans le label la phrase a l'indice 0
	area.input_event.connect(_on_area_input_event)
	# on "connecte" le signal input_event du Area2D à la fonction _on_area_input_event()
	#   ça veut dire : "quand quelqu’un clique dans la zone (CollisionShape2D), donc fait un event
	#      appelle automatiquement la fonction _on_area_input_event()"
	
			#LE MAGASIN SE REMPLI
	for obj in objets:
		var grille= GridContainer.new()
		grille.name="GRILLE"+obj
		grille.columns=1

		
		var texture_rect = TextureRect.new()
		var overlay = TextureRect.new()

		texture_rect.texture = load("res://images/cadreObjets.png")		#cadres
		overlay.texture = load("res://images/objets/" + obj + ".png")	#icon des objets
		
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.custom_minimum_size = Vector2(96, 96) 
		grille.add_child(texture_rect)
		#grille.add_child(overlay)
		

		# Creer la checkbox
		var check = CheckBox.new()
		check.name="CHECK"+obj
		check.text = obj
		#on connecte chaque checkbox a la fct _check_a_checkbox lorsque elle est "toggled" (cochee)
		check.connect("toggled", Callable(self, "_check_a_checkbox").bind(check))


		grille.add_child(check)


		# Enfin, ajoute dans le HFlowContainer
		h_flow_container.add_theme_constant_override("h_separation", 5)
		h_flow_container.add_theme_constant_override("v_separation", 5)

		

		h_flow_container.add_child(grille)


###########################################################################


	#LA FCT QUI GERE LE MAX: 2 CHECKBOX CHOISIES		
func _check_a_checkbox(button_pressed: bool, toggled_checkbox: CheckBox) -> void:
	var checked_count = 0 #compteur de nb de checkbox deja cliquee
	
	for obj in objets: #parcours de la liste d'objets
		var gr = h_flow_container.get_node("GRILLE" + obj) #on recup la grille (image+checkbox)
		var check = gr.get_node("CHECK" + obj) #dans chaque grille on recup juste la checkbox
		if check.button_pressed: #si la checkbox est click on incremente checked_count
			checked_count += 1
	
	if checked_count > 2 and button_pressed: #si au final il y'a 
		toggled_checkbox.button_pressed = false


#############################################################################

			#EVOLUTION DES DIALOGUES
func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed: #si l'evenemt est un clique
		index += 1 #l'indice augmente de 1

		#phrase secrete
		if index == 10:
			label.text = "T'as fini ?!"
			return
			
		if index == 20:
			label.text = "Juste vas t'en..."
			return

		if index == 30:
			label.text = "DEGAGEEEEEE !"
			label.add_theme_font_size_override("font_size", 60)
			return




		# Plus de 3 clics → reste sur la dernière phrase
		if index > 2:
			label.text = dialogues[2]
			label.add_theme_font_size_override("font_size", 30)

			
			#comportement normal
		else:
			label.text = dialogues[index]

######################################################################
#RESIZE DES OBJET DANS LES CADRES
func resize() ->void: 
	pass;

######################################################################


	#LORSQUE LE BOUTON ACHETER EST CLICK
func _on_button_acheter_pressed() -> void:
	#Recup des objets coches
	for obj in objets: #parcours de la liste d'objets
		var gr = h_flow_container.get_node("GRILLE" + obj) #on recup la grille (image+checkbox)
		var check = gr.get_node("CHECK" + obj) #dans chaque grille on recup juste la checkbox
		#PARTIE A remettre pour gestion du stock:
		#if check.button_pressed: #si la checkbox est click on incremente checked_count
			#ajoute_objet(obj, 3, stock);	
	
	
	
	#retour vers la piece
	caisse.play()
	await get_tree().create_timer(1.10).timeout
	#get_tree().change_scene_to_file("res://scenes/dortoir.tscn")
	self.visible=false
	#var dortoir_scene = preload("res://scenes/dortoir.tscn").instantiate()
	#dortoir_scene.stock = self.stock  # ← passe le stock actuel
	#get_tree().root.add_child(dortoir_scene)
	#get_tree().current_scene.queue_free()
