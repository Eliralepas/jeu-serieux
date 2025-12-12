extends checkBTN

class_name BasePiece

#les attributs que chaque piece doit avoir: 
#(adaptez les chemins si besoin)

# pour la gestion du JSON (adaptez les chemins si besoin)
const PATH : String = "res://save_game.json"
const NOM_SALLE : String = "cuisine"

@onready var porte= $songs/porte
@onready var magasinBackground = $songs/magasinBackground
@onready var talkingPeople=$songs/talkingPeople
@onready var mainBackground=$songs/mainBackground

@onready var broken_object: Objet_casse = $BrokenObject
@onready var btn_reparer: Button = $BrokenObject/ObjetCasse/BtnReparer
@onready var objet_casse: Button = $BrokenObject/ObjetCasse

@onready var menu = $Menu #un menu pour poser/retirer des objets
@onready var store= $Store #chaque piece a un magasin

@onready var conteneur=$Menu/Panel/VBoxContainer
@onready var objects := { #tous les elements possible dans la piece(donc achetable depuis le magasin)
	#"nom": $cheminImage,
	"radiateur": $ListeObjets/radiateur,
	"cd":$ListeObjets/cd
	#"rideaux": $ListeObjets/rideaux
	#"lampe": $ListeObjets/lampe
}

@export var Personnages : Node2D

var budget := 500 : #A lire depuis le Json
	set(val) :
		budget = val
		$Store.budget = val
var stock :Array= [] #Les objets qu'on a (soit des qu'on entre dans la piece soit qu'on achete du magasin)
						#JUSTE LE NOM

func _ready() -> void:
	setup();

func get_stock() ->Array:
	return stock

func get_objects() -> Dictionary:
	return objects
	#cette fonction pourra etre utiliser dans tous les ready
func setup() -> void:
	add_check_button(stock, objects, conteneur) #on lui donne ce qu'on a et TOUS les objets possibles
	connect_the_check_boxs(objects) #on lui donne tous les objets possible, elle gere pour trier
	for obj : Object_piece in objects.values():
		obj.set_visibility(false)
	$Menu._on_menu_mur_color_pressed()
	
	$Menu.change_budget(budget) #cast int en str
	
		#on connecte les 2 btn du menu auc fct qui leurs sont attribuer
	$Menu/Panel/btn_Magasin.connect("pressed", Callable(self, "_magasin_pressed"))
	$Menu/Panel/btn_Finaliser.connect("pressed", Callable(self, "_finaliser_pressed"))
	
		#on connecte le petit menu mur a sa fct
	$Menu/Panel/MenuMurColor.get_popup().connect("id_pressed", Callable(self, "_on_mur_color_selected"))
	
		#the magasin
	$Store/Btn_Acheter.connect("pressed", Callable(self, "_on_button_acheter"))
	$Store/Btn_Sortir.connect("pressed", Callable(self, "_on_btn_sortir"))


	#cette fonction est utile si on a un stock par defaut 
func default_stock(stk: Array)->void:
	stock=stk

func ajout_obj(obj: Dictionary) -> void:
	for key in obj.keys():
		stock.append(obj[key]) 


func _magasin_pressed():
	$Menu._on_magasin_pressed($Store,porte, magasinBackground, talkingPeople, mainBackground)

func _finaliser_pressed():
	_calcul_score()
	$Menu._on_finaliser_pressed()

# on calculer un certain score
# | 	les besoins humains : 40%
# | 	l'adaptation au saison : 25%
# | 	la réparation d'un objet : 15%
# | 	choix de la bonne couleur du mur : 20%
func _calcul_score() ->void :
	#on rempli le json qui a été crée dans la source du code
	#on vérifie si tout d'abord nous avons écouter l'avis des résidents (40%)
	#pour chaque résident satisfait on donne +1
	var nbContent : int = 0
	for perso : Personnage in Personnages.get_children() :
		if perso.is_content() :
			nbContent = nbContent + 1
			
	#Avec 3 résidents = 3 points max, on normalise
	var scoreTotal : float = nbContent/3 * 4
	
	#si l'objet a été réparé (15%)
	var repare : bool = broken_object.est_repare()
	if repare :
		scoreTotal += 1.5
	
	#vérifier si la bonne couleur de mur a été choisie (20%)
	
	
	#pour le calcul de l'adaptation au saison (on récupère la saison du json)
	var file = FileAccess.open(PATH, FileAccess.READ_WRITE)
	if file :
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		
		if json!=null:
			# 0 si été, 1 si hiver
			var saison : int = json[NOM_SALLE]["saison"]
			if saison == 0 : #si été
				#vérifier si le rideau est visible
				var rideau = objects["rideaux"]
				if rideau.visible : 
					scoreTotal += 2.5
			elif saison == 1 : 
				#vérifier si la lampe/lumière est visible
				var lampe = objects["lampe"]
				if lampe.visible : 
					scoreTotal += 2.5
			json[NOM_SALLE]["score"] = scoreTotal
	pass

func reconnect_menu_buttons():
	var btnMag = $Menu/Panel/btn_Magasin
	var btnFin = $Menu/Panel/btn_Finaliser

	if not btnMag.is_connected("pressed", Callable(self, "_magasin_pressed")):
		btnMag.connect("pressed", Callable(self, "_magasin_pressed"))

	if not btnFin.is_connected("pressed", Callable(self, "_finaliser_pressed")):
		btnFin.connect("pressed", Callable(self, "_finaliser_pressed"))
		
func _on_button_acheter() :
	$Store._on_button_acheter_pressed()
	
func _on_btn_sortir() :
	$Store._on_btn_sortir_pressed()

func _on_btn_reparer_pressed() -> void:
	var cout : int = broken_object.get_cout()
	if cout > budget :
		print("cout trop élévé")
		return
	
	%AnimationRepare.play("reparer")
	btn_reparer.visible = false
	objet_casse.disabled = true
	objet_casse.mouse_default_cursor_shape = Control.CURSOR_ARROW
	budget-=cout
	$Menu.change_budget(budget)
