	#A remplacer par sa propre scene!!!!
extends "res://scripts/grahics.gd"

@onready var parle = $Dialogue
@onready var area = $Area2D
@onready var h_flow_container: HFlowContainer = $HFlowContainer

@onready var caisse:= $Songs/purchase



			#les differentes phrases
var dialogues = [
	"Qu'est-ce que tu veux ?",
	"Me dévalise pas ! Pas plus de quatres articles.",
	"Accélère, j'ai d'autres clients !" # dernière phrase normale
]

		#objets du magasin
		#tab de listes["nom", prix]
var objets = [
	["armoire", 200],
	["cadres", 50], 
	["coffre", 100],
	["commode", 100], 
	["grand_tapis", 70], 
	["lampe", 65],
	["plant", 100], 
	["plante", 100], 
	["pouf", 130]
	]


var index = 0 #pour avoir le nb de clicks sur le dialogue
var nb_objet=0 #pour compter les objets deja achetes

#####################################################################################

func _ready(): #quand la scene demarre
	print("///////////////////////////////////////////////////////////")
	parle.text = dialogues[index] #on met dans le label la phrase a l'indice 0
	area.input_event.connect(_on_area_input_event)
	# on "connecte" le signal input_event du Area2D à la fonction _on_area_input_event()
	#   ça veut dire : "quand quelqu’un clique dans la zone (CollisionShape2D), donc fait un event
	#      appelle automatiquement la fonction _on_area_input_event()"
	remplir_magasin()
			


###########################################################################
func remplir_magasin() -> void:
	#LE MAGASIN SE REMPLI
	for obj in objets:
		var grille= GridContainer.new()
		grille.name="GRILLE"+obj[0]
		grille.columns=1

		
		var texture_rect = TextureRect.new()
		var overlay = TextureRect.new()

		texture_rect.texture = load("res://images/cadreObjets.png")		#cadres
		overlay.texture = load("res://images/objets/" + obj[0] + ".png")	#icon des objets
		
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.custom_minimum_size = Vector2(96, 96) 
		grille.add_child(texture_rect)
		#grille.add_child(overlay)
		

		# Creer la checkbox
		var check = CheckBox.new()
		check.name="CHECK"+obj[0]
		check.text = obj[0]
		#on connecte chaque checkbox a la fct _check_a_checkbox lorsque elle est "toggled" (cochee)
		check.connect("toggled", Callable(self, "_check_a_checkbox").bind(check))


		grille.add_child(check)

		#Creer les label de prix
		var prix = Label.new()
		prix.name = "Label%d" % obj[1]
		prix.text = "%d €" % obj[1]
		grille.add_child(prix)
		
		
		# Enfin, ajoute dans le HFlowContainer
		h_flow_container.add_theme_constant_override("h_separation", 5)
		h_flow_container.add_theme_constant_override("v_separation", 5)

		

		h_flow_container.add_child(grille)





	#LA FCT QUI GERE LE MAX: 4 CHECKBOX CHOISIES		
func _check_a_checkbox(button_pressed: bool, toggled_checkbox: CheckBox) -> void:
	var checked_count = 0 #compteur de nb de checkbox deja cliquee
	
	for obj in objets: #parcours de la liste d'objets
		var gr = h_flow_container.get_node("GRILLE" + obj[0]) #on recup la grille (image+checkbox)
		var check = gr.get_node("CHECK" + obj[0]) #dans chaque grille on recup juste la checkbox
		if check.button_pressed: #si la checkbox est click on incremente checked_count
			checked_count += 1
	
	if checked_count > 4 and button_pressed: #si au final il y'a deja 4
		toggled_checkbox.button_pressed = false


#############################################################################

			#EVOLUTION DES DIALOGUES
func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed: #si l'evenemt est un clique
		index += 1 #l'indice augmente de 1

		#phrase secrete
		if index == 10:
			parle.text = "T'as fini ?!"
			return
			
		if index == 20:
			parle.text = "Juste vas t'en..."
			return

		if index == 30:
			parle.text = "DEGAGEEEEEE !"
			parle.add_theme_font_size_override("font_size", 60)
			return




		# Plus de 3 clics → reste sur la dernière phrase
		if index > 2:
			parle.text = dialogues[2]
			parle.add_theme_font_size_override("font_size", 30)

			
			#comportement normal
		else:
			parle.text = dialogues[index]

######################################################################
#RESIZE DES OBJET DANS LES CADRES
func resize() ->void: 
	pass;

######################################################################


	#LORSQUE LE BOUTON ACHETER EST CLICK
func _on_button_acheter_pressed() -> void:
	var total=0;
	var possible=false
	#Recup des objets coches
	for obj in objets: #parcours de la liste d'objets
		var gr = h_flow_container.get_node("GRILLE" + obj[0]) #on recup la grille (image+checkbox)
		var check = gr.get_node("CHECK" + obj[0]) #dans chaque grille on recup juste la checkbox
		if check.button_pressed: #si la checkbox est click on incremente checked_count
			#Ajout des objets achetes au stock de la piece
			total += obj[1]
			if total < budget:
				var ajoutee = ajoute_objet(obj, stock);	
				if ajoutee : #si objet pas deja dans le stock
					budget -= obj[1]
					possible=true
				else:
					parle.text="Tu ne sais meme pas que tu l'as deja?"
	
		#retour vers la piece
	if possible:
		caisse.play()
		await get_tree().create_timer(1.10).timeout

		self.visible=false
		var backgroundMagasin = get_parent().get_node("songs/magasinBackground")
		var people = get_parent().get_node("songs/talkingPeople")
		var mainbackground = get_parent().get_node("songs/mainBackground")
		var argent= get_parent().get_node("Menu/Panel/Label")
		
		backgroundMagasin.stop()
		people.stop()
		mainbackground.play()
		
		argent.text = "Budget : %d " % budget

		get_parent().clear_check_boxes() #evite d'avoir 2fois le meme btn
		get_parent().add_check_box() #ajoute les btn du stock
		get_parent().connect_the_check_box() #donne a chaque btn le bon event
		

		
	else :
		parle.text = "Haha dans tes reves, t'as pas l'argent"




	#utilise pour que lorsq'on revient dans le magasin les checkbox d'avant ne seront plus cochees
func decoche_tout() -> void:
	for obj in objets: #parcours de la liste d'objets
		var gr = h_flow_container.get_node("GRILLE" + obj[0]) #on recup la grille (image+checkbox)
		var check = gr.get_node("CHECK" + obj[0]) #dans chaque grille on recup juste la checkbox
		if check.button_pressed: #si la checkbox est click on incremente checked_count
			check.button_pressed=false
