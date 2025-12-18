extends Control
func _ready():
	$Timer.start()

func _on_timer_timeout():
	
	var score=get_total_score_from_json()
	
	if score > 50 :
		$sceneJoyeuse.visible = true
		$Label.visible = true
	if score <= 50 :
		$sceneTriste.visible = true
		$Label.visible = true
		
		
func get_total_score_from_json() -> int:
	var file = FileAccess.open("res://save/save_game.json", FileAccess.READ) #ouvrire le fichier
	if file == null:
		print("Erreur ouverture JSON")
		return 0

	var json_text = file.get_as_text() #lire le fichier
	file.close()#fermer le fichier

	var data = JSON.parse_string(json_text) #transformer du texte JSON en données utilisables dans Godot
	if data == null:
		print("JSON invalide")
		return 0

	var total_score = 0 #calcule du score 


#a modifier selon new structure du JSON
	total_score += data["cuisine"]["score"] 
	total_score += data["dortoir"]["score"]
	total_score += data["salle_de_bain"]["score"]
	total_score += data["salon"]["score"]

	return total_score


# 0 - 20 : nul cata
# 20 -40 : bof
# 40 - 60 : bien
# 60 - 80 : wow
