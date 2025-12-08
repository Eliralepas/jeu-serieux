extends Node2D

func _ready():
	$wall_color_menu.get_popup().connect("id_pressed", Callable(self, "_on_wall_color_selected"))	


func _on_wall_color_menu_pressed() -> void:
	var wallMenu = $wall_color_menu
	wallMenu.get_popup().clear()
	wallMenu.get_popup().add_item("Vert", 0)
	wallMenu.get_popup().add_item("Beige", 1)
	wallMenu.get_popup().add_item("Rouge", 2)

func _on_wall_color_selected(c : int) -> void:
	wall_color(c)

func wall_color(c : int) -> void:
	var green = $Wall_Colors/green_wall
	var red = $Wall_Colors/red_wall
	var beige = $Wall_Colors/beige_wall
	
	match c:
		0:
			green.visible=true
			beige.visible=false
			red.visible=false
		1:
			green.visible=false
			beige.visible=true
			red.visible=false
		2:
			green.visible=false
			beige.visible=false
			red.visible=true
