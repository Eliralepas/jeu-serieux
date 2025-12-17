extends Control

@onready var animation_player: AnimationPlayer = $room/animationLock
@onready var room: TextureButton = $room

func _ready() -> void:
	animation_player.play("transparence")
	room.mouse_default_cursor_shape = Control.CURSOR_ARROW
	pass


func unlock() -> void:
	animation_player.play("deverouiller")
	room.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_room_pressed() -> void:
	var scene_path = "res://scenes/" + name.to_lower() + ".tscn"
	print(scene_path)

	if FileAccess.file_exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_warning("⚠️ La scène n'existe pas : " + scene_path)
