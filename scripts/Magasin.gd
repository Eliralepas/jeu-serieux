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
		grille.columns=1

		
		# Use TextureRect instead of Sprite2D
		var texture_rect = TextureRect.new()
		var overlay = TextureRect.new()

		#texture_rect.texture = load("res://images/objets/" + obj + ".png")		
		texture_rect.texture = load("res://images/cadreObjets.png")		
		
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.custom_minimum_size = Vector2(96, 96) # adjust size if needed
		grille.add_child(texture_rect)
		

		# Crée la checkbox
		var check = CheckBox.new()
		check.text = "Choisir"
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
