## @class_doc
## @description A container for managing a list of game objects.
## Provides functionality to retrieve random objects from its children.
## @tags utility, rng, object_management
extends Node2D
class_name ListeObjet

## @func_doc
## @description Selects and returns a random object from the list of children nodes.
## @return ObjectPiece A randomly selected object from the list.
## @tags utility, rng
func objectRandom() -> ObjectPiece:
	var n: int = get_child_count()
	var index_random: int = randi_range(0, n-1)
	return get_child(index_random)
