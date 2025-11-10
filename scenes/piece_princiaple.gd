extends Node2D


func click_area_dortoir(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/dortoir.tscn")

# A SUPRIMER
func resize(sprite : Sprite2D, texture : TextureRect) :
	var size : Vector2 = sprite.texture.get_size()
	var x: float = size.x
	var y: float = size.y
	var scale_factor: float = min(x / texture.size.x, y / texture.size.y)
	sprite.scale = Vector2.ONE / scale_factor
	texture.add_child(sprite)
	sprite.position = texture.size/2
