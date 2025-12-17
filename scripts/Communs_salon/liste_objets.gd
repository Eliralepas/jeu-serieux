extends Node2D
class_name ListeObjet

# renvoie de la liste des objets un objet random
func objectRandom() -> ObjectPiece:
	var n: int = get_child_count()
	var index_random: int = randi_range(0, n-1)
	return get_child(index_random)
