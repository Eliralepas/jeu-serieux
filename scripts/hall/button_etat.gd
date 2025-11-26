extends Control

@onready var animation_player: AnimationPlayer = $Room/AnimationPlayer

func _ready() -> void:
	pass


func unlock() -> void:
	animation_player.play("deverouiller")


func _on_room_pressed() -> void:
	var scene_path = "res://scenes/" + name.to_lower() + ".tscn"
	print(scene_path)

	if FileAccess.file_exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_warning("⚠️ La scène n'existe pas : " + scene_path)
