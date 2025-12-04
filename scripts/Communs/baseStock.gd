extends Node2D
class_name Stock
#CLASSE AVEC TOUTES LES FCT DE BASE DES STOCK


#ajout d'objet dans le stock (une fois acheter du magasin)

#ici on a utiliser une array car un objet est defini par un nom et un prix
func ajoute_objet(objet: String, stock: Array) -> bool:
	for item in stock: 
		if item==objet: #si l'objet existe deja dans le stock
			return false
			
	stock.append(objet); #sinon on l'ajoute dans le stock
	return true
			

#suppression d'un objet du stock (pour une fonctionnalité qu'on a pas pu mettre en place)
func supprime_objet(objet: String, stock: Array) -> void:
	stock.erase(objet);

#afficher tous les objets dans la sortie standar (utile pour les tests)
func lire_stock(stock: Array) ->void:
	for key in stock:
		print("objet : %s %", stock)
		
