extends Node
#CLASSE AVEC TOUTES LES FCT DE BASE DES PIECES

#*on peut faire que un objet a comme duree de vie un int, et chaque round si il 
#n'est pas utilise ce int descend.
#A chaque debut de round on verifie le stock des pieces, si un des objet a une duree de vie
#negative on le remove


func _ready() -> void:
	pass;

func ajoute_objet(objet: String, duree: int, stock: Dictionary) -> void:
	stock[objet]=duree;
	
func supprime_objet(objet: String, stock: Dictionary) -> void:
	stock.erase(objet);

func lire_stock(stock: Dictionary) ->void:
	for key in stock.keys():
		print("l'objet : %s a une durée de vie: %d" % [key, stock[key]])
