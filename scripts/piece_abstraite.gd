extends Node
#CLASSE AVEC TOUTES LES FCT DE BASE DES PIECES

#*on peut faire que un objet a comme duree de vie un int, et chaque round si il 
#n'est pas utilise ce int descend.
#A chaque debut de round on verifie le stock des pieces, si un des objet a une duree de vie
#negative on le remove


func _ready() -> void:
	pass;

func ajoute_objet(objet: Array, stock: Array) -> bool:
	for item in stock: 
		if item==objet[0]:
			return false
			
	stock.append(objet[0]);
	return true
			

	
func supprime_objet(objet: String, stock: Array) -> void:
	stock.erase(objet);

func lire_stock(stock: Array) ->void:
	for key in stock:
		print("objet : %s %", stock)
