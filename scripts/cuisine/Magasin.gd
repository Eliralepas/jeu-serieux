extends checkBtn

@onready var scene_cadre: PackedScene = preload("res://scenes/cadre.tscn")

@onready var parle = $dialogue
@onready var area = $area2D
@onready var h_flow_container: HFlowContainer = $hFlowContainer

@onready var caisse:= $songs/purchase 

@onready var budget
@onready var objets_achetes=0

@onready var test=get_parent().get_node("menu/panel/vBoxContainer")

@onready var stock = get_parent().get_stock()
@onready var stuff
			#les differentes phrases
var dialogues = [
	"Me dévalise pas ! Pas plus de quatres articles.\nOn est au Pole Nord ici !",
	"Qu'est-ce que tu veux ?",
	"Accélère, j'ai d'autres clients !" # dernière phrase normale
]

		#objets du magasin
		#tab de listes["nom", prix]
		#! chaque piece a des objets differents
var objets = [
	["radiateur",20],
	["lampe",30],
	["bouilloire",10],
	["micro_ondes",40],
	["cafetiere",50],
	["four", 10],
	["poubelle", 12]
]


var index = 0 #pour avoir le nb de clicks sur le dialogue
var nb_objet=0 #pour compter les objets deja achetes

#####################################################################################


func _ready():
	print("///////////////////////////////////////////////////////////")
	await get_tree().process_frame #temps pour que le parent fasse son ready
	stuff = get_parent().get_objects()  # récupère ici
	parle.text = dialogues[index]
	#area.input_event.connect(_on_area_input_event)
	remplir_magasin()
	
	# connecte les boutons du store
	#$Btn_Acheter.connect("pressed", Callable(self, "_on_button_acheter_pressed"))
	#$Btn_Sortir.connect("pressed", Callable(self, "_on_btn_sortir_pressed"))

###########################################################################
func ajouter_obj_au_magasin(nom: String, prix: int) -> void: #si on voudra ajouter un item au magasin apres 
	var element = [nom, prix] # pas necessairement utile mais elle existe 
	objets.append(element)
###########################################################################
func remplir_magasin() -> void:
	#remplir le magasin avec les différents objets (prix, button, image, nom)
	for obj in objets:
		var cadre : CadreObjet = scene_cadre.instantiate()
		cadre.name = "GRILLE" + obj[0]
		
		#Ajout de l'image (le chemin a changé si besoin)
		var texture_objet = cadre.getObjet()
		var image_path : String = "res://assets/meubles/"+obj[0]+".png"
		var image: Image = Image.new()
		var error = image.load(image_path)
		if error != OK:
			push_error("Erreur")
			return
		var texture = ImageTexture.create_from_image(image)
		texture_objet.texture = texture
		
		var sprite = cadre.getCadre()
		
		# changer la taille de l'image de l'objet
		var size : Vector2 = sprite.texture.get_size()
		var x: float = size.x - 6
		var y: float = size.y - 6
		var image_size : Vector2 = texture.get_size()
		
		# Calcul du facteur d'échelle
		var scale_factor: float = min(x / image_size.x, y / image_size.y)
		texture_objet.scale = Vector2.ONE * scale_factor
		
		#Ajout le nom de l'objet
		var objet_check = cadre.getCheckButton()
		objet_check.text = obj[0]
		objet_check.disabled = false
		
		#Ajout du label prix
		var objet_prix = cadre.getLabel()
		objet_prix.text = str(obj[1]) + " $"
		
		#on connecte chaque checkbox a la fct _check_a_checkbox lorsque elle est "toggled" (cochee)
		objet_check.connect("toggled", Callable(self, "_check_a_checkbox").bind(objet_check))
		
		h_flow_container.add_child(cadre)

	#LA FCT QUI GERE LE MAX: 4 CHECKBOX CHOISIES		
func _check_a_checkbox(button_pressed: bool, toggled_checkbox: CheckBox) -> void:
	var checked_count = 0 #compteur de nb de checkbox deja cliquee
	
	for obj in objets: #parcours de la liste d'objets
		var gr : CadreObjet = h_flow_container.get_node("GRILLE" + obj[0]) #on recup la grille (image+checkbox)
		var check = gr.getCheckButton() #dans chaque grille on recup juste la checkbox
		if check.button_pressed: #si la checkbox est click on incremente checked_count
			checked_count += 1
	
	if checked_count > 4 and button_pressed: #si au final il y'a deja 4
		toggled_checkbox.button_pressed = false


#############################################################################

func _on_btn_sortir_pressed() -> void:
	decoche_tout()
	magasin_non_visible()

	#LORSQUE LE BOUTON ACHETER EST CLICK
	
func _on_button_acheter_pressed() -> void:
	var total = 0
	var checked_objects = []
	
	# Récupère tous les objets cochés
	for obj in objets: #recupere le prix final
		var gr : CadreObjet = h_flow_container.get_node("GRILLE" + obj[0]) #recup grille de chaque obj
		var check = gr.getCheckButton() #recup checkbox
		if check.button_pressed: #si obj choisi
			total += obj[1]#ajout du prix au total
			checked_objects.append(obj)#ajout de l'objet a la liste d'objets
			
			
	if (objets_achetes + checked_objects.size()) > 4: #verifie qu'on ne veut pas plus de 4 objets
		parle.text = "On a dit uniquement  4 objets!"

	# Vérifie si le budget suffit
	elif total <= budget: 
		var any_added = false
		for obj in checked_objects:
			var ajoutee = get_parent().ajoute_objet(obj[0], stock)
			if ajoutee:
				any_added = true
			else:
				objets_achetes -= 1 # On décrémente le nombre d'objet
				total -= obj[1] # On retire le prix de l'objet déjà possédé au résultat
				parle.text = "Tu l'as déjà, je ne vends pas en double."

		if any_added:
			budget -= total  # soustraction globale ici
			objets_achetes += checked_objects.size()  # ← correction ici
			print(objets_achetes)
			parle.text = "Hahaha j'aime quand tu depenses."

			caisse.play()
			await get_tree().create_timer(1.1).timeout

			magasin_non_visible()
			get_parent().clear_check_boxes()
			get_parent().add_check_button(stock, stuff, test)
			get_parent().reconnect_menu_buttons()
			get_parent().connect_the_check_boxs(stuff)
			get_parent().set_budget(budget)
	else:
		parle.text = "Haha dans tes rêves, t'as pas l'argent"


	#utilise pour que lorsq'on revient dans le magasin les checkbox d'avant ne seront plus cochees
func decoche_tout() -> void:
	for obj in objets: #parcours de la liste d'objets
		var gr : CadreObjet = h_flow_container.get_node("GRILLE" + obj[0]) #on recup la grille (image+checkbox)
		var check = gr.getCheckButton() #dans chaque grille on recup juste la checkbox
		check.disabled = false 
		if check.button_pressed: #si la checkbox est click on incremente checked_count
			check.button_pressed=false


func magasin_non_visible() -> void:
# récupère le node du magasin explicitement
	var magasin_node = get_parent().get_node("store")  
	magasin_node.visible = false

	var parent = get_parent()
	var backgroundMagasin = parent.get_node("songs/magasinBackground")
	var people = parent.get_node("songs/talkingPeople")
	var mainbackground = parent.get_node("songs/mainBackground")
	#var argent = parent.get_node_or_null("Menu/Panel/Label")

	backgroundMagasin.stop()
	people.stop()
	mainbackground.play()
	
	get_parent().get_node("menu").change_budget(budget);


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
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
	pass # Replace with function body.
