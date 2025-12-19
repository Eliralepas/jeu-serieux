## @class_doc
## @description Controls a character's behavior, including displaying emotions (content/not content) and assigning random preferences for objects.
## @tags character, game_logic, ui

## @depends ListeObjet: uses Retrieves random objects to determine preference.
## @depends ObjectPiece: uses Interacts with object pieces to register likes/dislikes.
extends Sprite2D
class_name Personnage

@export var ListeObjets : ListeObjet
@onready var bulle : Sprite2D = get_node("bulle")

@onready var content: TextureRect = $emotion/content
@onready var pas_content: TextureRect = $emotion/pasContent


## @func_doc
## @description Initializes character preferences. Picks a random object and decides if the character likes it or not.
## @tags life_cycle, initialization, rng
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


## @func_doc
## @description Resizes a sprite to fit within a texture rect, maintaining aspect ratio.
## @param sprite: Sprite2D The sprite to resize.
## @param texture: TextureRect The container to fit into.
## @tags utility, visual
func resize(sprite : Sprite2D, texture : TextureRect) :
	var size : Vector2 = sprite.texture.get_size()
	var x: float = size.x
	var y: float = size.y
	var scale_factor: float = min(x / texture.size.x, y / texture.size.y)
	sprite.scale = Vector2.ONE / scale_factor
	
	
	
	texture.add_child(sprite)
	sprite.position = texture.size/2

## @func_doc
## @description Toggles the thought bubble visibility.
## @tags event_handler, ui
func _on_button_pressed() -> void:
	bulle.visible = not bulle.visible
	pass # Replace with function body.

## @func_doc
## @description Sets the visible emotion based on contentment.
## @param est_content: bool True if content, False otherwise.
## @tags visual, logic
func visible_emotion(estcontent : bool) -> void:
	if estcontent :
		content.visible = true
		pas_content.visible = false
	else :
		content.visible = false
		pas_content.visible = true

## @func_doc
## @description Checks if the character is currently content (based on visual state).
## @return bool True if content.
## @tags state, getter
func is_content() -> bool : 
	if content.visible && !pas_content.visible : 
		return true
		
	if pas_content.visible && !content.visible: 
		return false
	return false
