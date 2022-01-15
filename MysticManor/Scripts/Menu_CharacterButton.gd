extends HBoxContainer

var CharacterName = ""
var MysteriesSolved = ""

func _ready():
	pass
	
func load_button():
	$VBoxContainer/ColorBackground/CharacterName.text = CharacterName
	$VBoxContainer/ColorBackground/MysterySolved.text = "~ Mysteries Solved: " + MysteriesSolved

func _on_PlayRandom_pressed():
	Global.set_player_dict(self.CharacterName)
	Global.start_random_mystery()
