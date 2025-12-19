extends checkBtn

class_name Salon

#les attributs que chaque piece doit avoir: 
#(adaptez les chemins si besoin)

# pour la gestion du JSON (adaptez les chemins si besoin)
const PATH : String = "res://save/save_game.json"
const NOM_SALLE : String = "salon"

@onready var porte= $songs/porte
@onready var magasinBackground = $songs/magasinBackground
@onready var talkingPeople=$songs/talkingPeople
@onready var mainBackground=$songs/mainBackground

@onready var broken_object: ObjetCasse = $brokenObject
@onready var btn_reparer: Button = $brokenObject/objetCasse/btnReparer
@onready var objet_casse: Button = $brokenObject/objetCasse

@onready var menu : Menu = $menu #un menu pour poser/retirer des objets
@onready var store : Magasin = $store #chaque piece a un magasin
@onready var murs: Mur = $murs

@onready var conteneur=$menu/panel/vBoxContainer
@onready var objects := { #tous les elements possible dans la piece(donc achetable depuis le magasin)
	#"nom": $cheminImage,
	"grand_tableau": $listeObjets/bigPainting,
	"grande_lampe":$listeObjets/grandeLampe,
	"bibliotheque":$listeObjets/bibliotheque,
	"petit_tableau1":$listeObjets/smallPainting1,
	"petit_tableau2":$listeObjets/smallPainting2,
	"tapis":$listeObjets/carpet,
	"plante":$listeObjets/plant,
	"fauteuil":$listeObjets/armchair,
	
	"rideaux": $listeObjets/rideaux,
	"lampe": $listeObjets/lampe

}

@export var Personnages : Node2D

var budget := 0 : #A lire depuis le Json
	set(val) :
		budget = val
		$store.budget = val
		print(budget)
		
var stock :Array= ["rideaux", "lampe"] #Les objets qu'on a (soit des qu'on entre dans la piece soit qu'on achete du magasin)
						#JUSTE LE NOM

func _ready() -> void:
	setup();

func get_stock() ->Array:
	return stock

func get_objects() -> Dictionary:
	return objects
	#cette fonction pourra etre utiliser dans tous les ready
	
## setup() is the main function in every room.
## It instanciates every object and thing the player can interact with in the room
func setup() -> void:
	broken_object.set_cout(60)
	add_check_button(stock, objects, conteneur) #on lui donne ce qu'on a et TOUS les objets possibles
	connect_the_check_boxs(objects) #on lui donne tous les objets possible, elle gere pour trier
	for obj : ObjectPiece in objects.values():
		obj.set_visibility(false)
	$menu._on_menu_mur_color_pressed()
	
	var file = FileAccess.open(PATH, FileAccess.READ)
	if file :
		var content = file.get_as_text()
		file.close()
		var json = JSON.parse_string(content)
		budget = json["budget"]
		$menu.change_budget(budget)
	else :
		push_error("Erreur ouverture du JSON")
	
		#on connecte les 2 btn du menu auc fct qui leurs sont attribuer
	$menu/panel/btnMagasin.connect("pressed", Callable(self, "_magasin_pressed"))
	$menu/panel/btnFinaliser.connect("pressed", Callable(self, "_finaliser_pressed"))
	
		#on connecte le petit menu mur a sa fct
	$menu/panel/menuMurColor.get_popup().connect("id_pressed", Callable(self, "_on_mur_color_selected"))
	
		#the magasin
	$store/btnAcheter.connect("pressed", Callable(self, "_on_button_acheter"))
	$store/btnSortir.connect("pressed", Callable(self, "_on_btn_sortir"))
	
	# ajout des objets dans le magasin avec le prix
	var objets = [
	["grand_tableau", 100],
	["grande_lampe", 35],
	["bibliotheque", 110],
	["petit_tableau1", 45],
	["petit_tableau2", 45],
	["tapis", 15],
	["plante", 40],
	["fauteuil", 70]
	]
	store.set_items(objets)
	store.set_salle(NOM_SALLE)
	
	# ajout des murs dans le menu murs
	var _murs : Dictionary = {
		"beige" = $murs/mur1,
		"rouge" = $murs/mur2,
		"vert" = $murs/mur3
	}
	murs.set_murs(_murs)
	murs.set_bonne_couleur("beige")


	#cette fonction est utile si on a un stock par defaut 
func default_stock(stk: Array)->void:
	stock=stk

func ajout_obj(obj: Dictionary) -> void:
	for key in obj.keys():
		stock.append(obj[key]) 

## Used in every room, transfers player to the store scene
func _magasin_pressed():
	$menu._on_magasin_pressed($store,porte, magasinBackground, talkingPeople, mainBackground)
	
	await get_tree().create_timer(1.5).timeout
	for perso : Personnage in Personnages.get_children() :
		perso.visible = false
	objet_casse.visible = false
	btn_reparer.visible = false

func _finaliser_pressed():
	_calcul_score()
	$menu._on_finaliser_pressed()

# on calculer un certain score qu'on le stocke dans le json
# | 	l'adaptation au saison : 5
# | 	la réparation d'un objet : 3
# | 	choix de la bonne couleur du mur : 4

## Present in every room, used to compute player score and decides what dialogue to show
func _calcul_score() ->void :
	var scoreTotal : float = 0
	var remarques : String = ""
	#on vérifie si tout d'abord nous avons écouter l'avis des résidents (40%)
	
	#pour le calcul de l'adaptation au saison (on récupère la saison du json)
	var file = FileAccess.open(PATH, FileAccess.READ_WRITE)
	if file :
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		
		if json!=null:
			# compter le nombre de résidents sont satisfaits
			var nbContent : int = 0
			for perso : Personnage in Personnages.get_children() :
				if perso.is_content() :
					nbContent+=1
					var jauge = json["personnages"][perso.name]
					json["personnages"][perso.name] = jauge + 1
				else :
					var jauge = json["personnages"][perso.name]
					json["personnages"][perso.name] = jauge - 1
			
			# remarque vis-à-vis du nombre de résidents contents
			if nbContent == 4 : 
				remarques += "Et bien, tout les résidents ont été satisfait !\n"
			elif nbContent == 2 || nbContent == 3:
				remarques += "On ne peut pas satisfaire tout le monde.\n"
			elif nbContent == 1 : 
				remarques += "Tu aurais pu faire mieux, j'ai eu beaucoup de plaintes.\n"
			else : 
				remarques += "Bon là... Tu fais aucun effort, tout le monde est de mauvaise humeur.\n"
			
			# contrainte au niveau du saison
			# vérifier si un certain item est posé qui influe le score de la pièce 
			# (change en focntion de la saison)
			var saison : int = json[NOM_SALLE]["saison"]
			if saison == 0 : #si été
				#vérifier si le rideau est visible
				var rideau = objects["rideaux"]
				if rideau.visible : 
					scoreTotal += 5
					remarques += "C'est une superbe idée d'avoir mis les rideaux, puisqu'il fait tout le temps jour durant cette saison.\n"
				else : 
					remarques += "Durant cette saison, il fait tout le temps jour...Des rideaux n'auraient fait de mal à personne.\n"
			elif saison == 1 : 
				#vérifier si la lampe/lumière est visible
				var lampe = objects["lampe"]
				if lampe.visible : 
					scoreTotal += 5
					remarques += "C'est une superbe idée d'avoir mis la lampe, il fait tout le temps nuit durant cette saison.\n"
				else : 
					remarques += "Durant cette saison, il fait tout le temps nuit...On aurait aimé voir plus de lumière.\n"
			
			# vérifier si l'objet a été réparé (si celui est réparé, cela lui rajoute des points)
			var repare : bool = broken_object.est_repare()
			if repare :
				scoreTotal += 3
				remarques += "C'est bien que tu aies pu réparer l'objet cassé, merci.\n"
			else : 
				remarques += "Ça aurait été bien de pouvoir réparer cet objet.\n"
				
			#vérifier si la bonne couleur de mur a été choisie
			if murs.bonne_couleur_choisie() :
				scoreTotal += 4
				remarques += "Bon, la couleur du mur plait à tout le monde, pas trop clair ni trop foncé.\n"
			else :
				remarques += "Bon, au niveau de la couleur du mur tu aurais pu faire plus d'effort.\n"
			
			# changement du json
			json["budget"] = budget
			json[NOM_SALLE]["remarques"] = remarques
			json[NOM_SALLE]["score"] = scoreTotal
			json["tour"] += 1
		_change_json(json)
		file.close()
	else : 
		print("Erreur sur la lecture du fichier json.")
		push_error("JSON")

## Writes changes to the save_game.json file
func _change_json(json) :
	var file_write := FileAccess.open(PATH, FileAccess.WRITE)
	if file_write:
		file_write.store_string(JSON.stringify(json, "\t", true))
		file_write.close()
	else:
		push_error("Impossible d'écrire le fichier JSON.")

func set_budget(_budget) :
	budget = _budget

func reconnect_menu_buttons():
	var btnMag = $menu/panel/btnMagasin
	var btnFin = $menu/panel/btnFinaliser

	if not btnMag.is_connected("pressed", Callable(self, "_magasin_pressed")):
		btnMag.connect("pressed", Callable(self, "_magasin_pressed"))

	if not btnFin.is_connected("pressed", Callable(self, "_finaliser_pressed")):
		btnFin.connect("pressed", Callable(self, "_finaliser_pressed"))
		
func _on_button_acheter() :
	for perso : Personnage in Personnages.get_children() :
		perso.visible = true
	objet_casse.visible = true
	$store._on_button_acheter_pressed()
	
func _on_btn_sortir() :
	for perso : Personnage in Personnages.get_children() :
		perso.visible = true
	objet_casse.visible = true
	$store._on_btn_sortir_pressed()


## Repare the broken object present in the room
func _on_btn_reparer_pressed() -> void:
	var cout : int = broken_object.get_cout()
	if cout > budget :
		print("cout trop élévé")
		return
	
	%animationRepare.play("reparer")
	btn_reparer.visible = false
	objet_casse.disabled = true
	broken_object.set_repare()
	objet_casse.mouse_default_cursor_shape = Control.CURSOR_ARROW
	budget-=cout
	$menu.change_budget(budget)
