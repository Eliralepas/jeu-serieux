extends Node2D

@onready var label = $Label
@onready var area = $Area2D
@onready var h_flow_container: HFlowContainer = $HFlowContainer




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

func _ready(): #quand la scene demarre
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

		
		# Use TextureRect instead of Sprite2D
		var texture_rect = TextureRect.new()
		var overlay = TextureRect.new()

		#texture_rect.texture = load("res://images/objets/" + obj + ".png")		
		texture_rect.texture = load("res://images/cadreObjets.png")		
		
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.custom_minimum_size = Vector2(96, 96) 
		grille.add_child(texture_rect)
		

		# Creer la checkbox
		var check = CheckBox.new()
		check.name="CHECK"+obj
		check.text = obj
		check.connect("toggled", Callable(self, "_check_a_checkbox"))

		grille.add_child(check)


		# Enfin, ajoute dans le HFlowContainer
		h_flow_container.add_theme_constant_override("h_separation", 5)
		h_flow_container.add_theme_constant_override("v_separation", 5)

		

		h_flow_container.add_child(grille)

		print("itération")




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


func _on_button_acheter_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/grahics.tscn")
	
func _check_a_checkbox() ->void: 
	var i = 0; #compte le nb de checkbox check
	
	#on verifie toutes les checkbox
	for obj in objets:
		var grille_name="GRILLE"+obj #chaque checkbox est dans une grille
		var check_name = "CHECK"+obj #le nom de chaque checkbox
		# récupère le noeud checkbox
		var gr = h_flow_container.get_node(grille_name) #on recul l'elem grille du hflowcontainer
		var checkbox = gr.get_node(check_name)#on recupere la checkbox de cette grille
		if checkbox.is_pressed(): #si la checkbox est On
			i+=1; #on incremente
	#apres avoir tout verifier	
	if i>= 2 : #si y'a deja deux check de cocher
		var checkbox = get_tree().get_last_event().target  # récupère la checkbox qui a declancher le signal
		checkbox.pressed = false  # decoche sa case
		


func _on_Checkbox_toggled(button_pressed: bool):
	
	var i = 0
	for obj in objets:
		var gr = h_flow_container.get_node("GRILLE" + obj)
		var check = gr.get_node("CHECK" + obj)
		if check.is_pressed():
			i += 1
	
	if i >= 2 and button_pressed:
		$HFlowContainer/checkTest.pressed = false # décoche la case qui vient d’être cochée
