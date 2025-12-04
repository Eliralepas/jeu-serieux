	#A remplacer par sa propre scene!!!!
extends checkBTN

@onready var parle = $Dialogue
@onready var area = $Area2D
@onready var h_flow_container: HFlowContainer = $HFlowContainer

@onready var caisse:= $Songs/purchase 

@onready var budget =500

@onready var test=get_parent().get_node("Menu/Control/Panel/VBoxContainer")

@onready var stock = get_parent().get_stock()
@onready var stuff
			#les differentes phrases
var dialogues = [
	"Qu'est-ce que tu veux ?",
	"Me dévalise pas ! Pas plus de quatres articles.",
	"Accélère, j'ai d'autres clients !" # dernière phrase normale
]

		#objets du magasin
		#tab de listes["nom", prix]
		#! chaque piece a des objetx differents
var objets = [
	["radiateur",20]
	]


var index = 0 #pour avoir le nb de clicks sur le dialogue
var nb_objet=0 #pour compter les objets deja achetes

#####################################################################################



func _ready():
	print("///////////////////////////////////////////////////////////")
	await get_tree().process_frame #temps pour que le parent fasse son ready
	stuff = get_parent().get_objects()  # récupère ici
	parle.text = dialogues[index]
	area.input_event.connect(_on_area_input_event)
	remplir_magasin()
	
	# connecte les boutons du store
	#$Btn_Acheter.connect("pressed", Callable(self, "_on_button_acheter_pressed"))
	#$Btn_Sortir.connect("pressed", Callable(self, "_on_btn_sortir_pressed"))

###########################################################################
func ajouter_obj_au_magasin(nom: String, prix: int) -> void: #si on voudra ajouter un item au magasin apres 
	var element = [nom, prix]								# pas necessairement utile mais elle existe 
	objets.append(element)
###########################################################################
func remplir_magasin() -> void:
	#LE MAGASIN SE REMPLI
	for obj in objets:
		var grille= GridContainer.new()
		grille.name="GRILLE"+obj[0]
		grille.columns=1

		
		var texture_rect = TextureRect.new()
		#var overlay = TextureRect.new()

		texture_rect.texture = load("res://assets/Magasin/cadreObjets.png")		#cadres
		#overlay.texture = load("res://images/objets/" + obj[0] + ".png")	#icon des objets
		
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
		prix.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
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
func _on_area_input_event(viewport, event, shape_idx)->void:
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


func _on_btn_sortir_pressed() -> void:
	decoche_tout()
	magasin_non_visible()

	#LORSQUE LE BOUTON ACHETER EST CLICK
	
func _on_button_acheter_pressed() -> void:
	var total = 0
	var checked_objects = []

	# Récupère tous les objets cochés
	for obj in objets: #recupere le prix final
		var gr = h_flow_container.get_node("GRILLE" + obj[0]) #recup grille de chaque obj
		var check = gr.get_node("CHECK" + obj[0]) #recup checkbox
		if check.button_pressed: #si obj choisi
			total += obj[1]#ajout du prix au total
			checked_objects.append(obj)#ajout de l'objet a la liste d'objets

	# Vérifie si le budget suffit
	if total <= budget: 
		var any_added = false
		for obj in checked_objects:
			var ajoutee = get_parent().ajoute_objet(obj[0], stock)
			if ajoutee:
				any_added = true
			else:
				parle.text = "Tu l'as deja, je ne vend pas en double."

		if any_added:
			budget -= total  # soustraction globale ici
			caisse.play()
			await get_tree().create_timer(1.1).timeout

			magasin_non_visible()
			get_parent().clear_check_boxes()
			get_parent().add_check_button(stock, stuff, test)
			get_parent().reconnect_menu_buttons()
			get_parent().connect_the_check_boxs(stuff)

		print("Budget ligne 200:", budget)

	else:
		parle.text = "Haha dans tes rêves, t'as pas l'argent"


	#utilise pour que lorsq'on revient dans le magasin les checkbox d'avant ne seront plus cochees
func decoche_tout() -> void:
	for obj in objets: #parcours de la liste d'objets
		var gr = h_flow_container.get_node("GRILLE" + obj[0]) #on recup la grille (image+checkbox)
		var check = gr.get_node("CHECK" + obj[0]) #dans chaque grille on recup juste la checkbox
		if check.button_pressed: #si la checkbox est click on incremente checked_count
			check.button_pressed=false


	
func magasin_non_visible() -> void:
# récupère le node du magasin explicitement
	var magasin_node = get_parent().get_node("Store")  
	magasin_node.visible = false

	var parent = get_parent()
	var backgroundMagasin = parent.get_node("songs/magasinBackground")
	var people = parent.get_node("songs/talkingPeople")
	var mainbackground = parent.get_node("songs/mainBackground")
	var argent = parent.get_node_or_null("Menu/Panel/Label")

	backgroundMagasin.stop()
	people.stop()
	mainbackground.play()
	
	get_parent().get_node("Menu").change_budget(budget);
