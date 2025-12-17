extends Node2D
class_name Mur

var bonne_couleur : String = "vert"
@onready var couleur_choisie : Sprite2D = $mur1
var murs : Dictionary ={ } 

func set_murs(murs_ : Dictionary):
	murs = murs_

func set_bonne_couleur(couleur : String) : 
	bonne_couleur = couleur

func change_couleur(couleur : Sprite2D) : 
	couleur_choisie.visible = false
	print(couleur_choisie.name +" : "+couleur.name)
	
	couleur_choisie = couleur
	couleur_choisie.visible = true
	print(couleur_choisie.name +" : "+couleur.name)
	

func bonne_couleur_choisie() ->bool :
	return murs[bonne_couleur].visible
