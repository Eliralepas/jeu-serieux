## @class_doc
## @description Base class providing fundamental stock management functionality.
## Allows adding, removing, and listing objects in an abstract stock array.
## @tags logic, inventory, data_structure
extends Node2D
class_name Stock
#CLASSE AVEC TOUTES LES FCT DE BASE DES STOCK

#ajout d'objet dans le stock (une fois acheter du magasin)

## @func_doc
## @description Adds a unique object string to the stock list.
## Prevents duplicate entries.
## @param objet: String The name/identifier of the object to add.
## @param stock: Array The list managing the stock items.
## @return bool True if the object was added, False if it already existed.
## @tags inventory, logi
func ajoute_objet(objet: String, stock: Array) -> bool:
	for item in stock: 
		if item==objet: #si l'objet existe deja dans le stock
			return false
	
	stock.append(objet); #sinon on l'ajoute dans le stock
	return true
			

## @func_doc
## @description Removes an object from the stock list.
## @param objet: String The name of the object to remove.
## @param stock: Array The stock list.
## @tags inventory, logic
func supprime_objet(objet: String, stock: Array) -> void:
	stock.erase(objet);

## @func_doc
## @description Prints the contents of the stock to the console for debugging.
## @param stock: Array The stock list to print.
## @tags debug, utility
func lire_stock(stock: Array) ->void:
	for key in stock:
		print("objet : %s %", stock)
