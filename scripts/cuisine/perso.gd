extends AnimatedSprite2D

@export var ListeObjets : ListeObjet
@onready var bulle : Sprite2D = get_node("Bulle")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !ListeObjets:
		push_error("%s : @export var ListeObjet est null" % name)
	var object : Sprite2D = Sprite2D.new()
	object.texture = ListeObjets.objectRandom().texture
	var texture_object: TextureRect = get_node("Bulle/Objet")
	resize(object, texture_object)
	
	var image_path: String
	if randi_range(0,1):
		image_path = "res://assets/bulle/coeur.png"
	else:
		image_path = "res://assets/bulle/croix.png"
	var image: Image = Image.new()
	var error = image.load(image_path)
	if error != OK:
		push_error("Erreur")
		return
	var avis = ImageTexture.create_from_image(image)
	var avis_sprite : Sprite2D = Sprite2D.new()
	avis_sprite.texture = avis
	var texture_avis: TextureRect = get_node("Bulle/Avis")
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
