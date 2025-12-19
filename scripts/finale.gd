extends Control
const PATH : String = "res://save/save_game.json"

func _ready():
	$Timer.start()

func _on_timer_timeout():
		
	var score=get_total_score_from_json()
	#var score = 10
	
	if score > 0 && score <= 20:
		$fin0.visible = true
		
	if score > 20 && score <= 40:
		$fin20.visible = true
		
	if score > 40 && score <= 60:
		$fin40.visible = true
		 
	if score > 60 && score <= 80:
		$fin60.visible = true

	$lblScore.text = $lblScore.text + str(score)
	$lblScore.visible = true

		
		
func get_total_score_from_json() -> int:
	var file = FileAccess.open(PATH, FileAccess.READ)
	var total_score
	if file :
		var content = file.get_as_text()
		file.close()
		var json = JSON.parse_string(content)
		total_score = json["score_total"]
	else :
		push_error("Erreur ouverture du JSON")

	return total_score


func _on_button_quitter_pressed() -> void:
	get_tree().quit()
