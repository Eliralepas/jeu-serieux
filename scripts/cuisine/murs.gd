extends Node2D
class_name Mur

const BONNE_COULEUR : String = "vert"

@onready var couleur_choisie : Sprite2D = $murVert

@onready var murs : Dictionary ={
	"bleu" : $murBleu,
	"rouge" : $murRouge,
	"vert" : $murVert
} 

func change_couleur(couleur : Sprite2D) : 
	couleur_choisie.visible = false
	
	couleur_choisie = couleur
	couleur_choisie.visible = true

func bonne_couleur_choisie() ->bool :
	return murs[BONNE_COULEUR].visible
