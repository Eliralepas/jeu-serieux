extends Sprite2D

class_name Personnage

@export var ListeObjets : ListeObjet
@onready var bulle : Sprite2D = get_node("bulle")

@onready var content: TextureRect = $emotion/content
@onready var pas_content: TextureRect = $emotion/pasContent

func _ready() -> void:
	if !ListeObjets:
		push_error("%s : @export var ListeObjet est null" % name)
	
	#On récupère un objet random de la liste d'objet
	var object : ObjectPiece = ListeObjets.objectRandom()
	var object_bulle : Sprite2D = Sprite2D.new()
	object_bulle.texture = object.texture
	var texture_object: TextureRect = get_node("bulle/objet")
	resize(object_bulle, texture_object)
	
	var image_path: String
	
	if randi_range(0,1):
		image_path = "res://assets/bulle/coeur.png"
		object.aime.append(self)
	else:
		image_path = "res://assets/bulle/croix.png"
		object.aimepas.append(self)
	var image: Image = Image.new()
	var error = image.load(image_path)
	if error != OK:
		push_error("Erreur")
		return
	var avis = ImageTexture.create_from_image(image)
	var avis_sprite : Sprite2D = Sprite2D.new()
	avis_sprite.texture = avis
	var texture_avis: TextureRect = get_node("bulle/avis")
	resize(avis_sprite, texture_avis)
	
	bulle.visible = false

func resize(sprite : Sprite2D, texture : TextureRect) :
	var size : Vector2 = sprite.texture.get_size()
	var x: float = size.x
	var y: float = size.y
	var scale_factor: float = min(x / texture.size.x, y / texture.size.y)
	sprite.scale = Vector2.ONE / scale_factor
	
	
	
	texture.add_child(sprite)
	sprite.position = texture.size/2

func _on_button_pressed() -> void:
	bulle.visible = not bulle.visible
	pass # Replace with function body.

func visible_emotion(estcontent : bool) -> void:
	if estcontent :
		content.visible = true
		pas_content.visible = false
	else :
		content.visible = false
		pas_content.visible = true

#retroune si le personnage est content ou non
func is_content() -> bool : 
	if content.visible && !pas_content.visible : 
		return true
		
	if pas_content.visible && !content.visible: 
		return false
	return false
