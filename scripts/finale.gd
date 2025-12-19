## @class_doc
## @description Handles the "Game Over" or final scoring screen.
## Reads the score from the save file and displays an appropriate ending.
## @tags ui, gameloop, ending

## @depends JSON: uses Parses save data to retrieve the score.
## @depends FileAccess: uses Reads the save file.
extends Control

## @const_doc
## @description Path to the save file.
## @tags config, data
const PATH : String = "res://save/save_game.json"

## @func_doc
## @description Starts the timer to delay the result display upon loading.
## @tags life_cycle, initialization
func _ready():
	$Timer.start()

## @func_doc
## @description Triggered when the timer ends. Reads the score and displays the corresponding ending screen.
## @tags event_handler, logic
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

	$lblScore.text = $lblScore.text + " " + str(score) + "/80"
	$lblScore.visible = true
	$Timer.stop()

## @func_doc
## @description Reads the total score from the JSON save file.
## @return int The total score of the player.
## @tags data, file_io
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

## @func_doc
## @description Quits the game application.
## @tags event_handler, system
func _on_button_quitter_pressed() -> void:
	get_tree().quit()
