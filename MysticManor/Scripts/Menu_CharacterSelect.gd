extends Control



func _ready():
	for Character in Global.CharDict:
		var CharacterButton = load("res://Scenes/Interface/Menu_CharacterButton.tscn").instance()
		CharacterButton.CharacterName = Character
		CharacterButton.MysteriesSolved = str(Global.CharDict[Character]["Solved"].size())
		CharacterButton.load_button()
		$Background/ScrollContainer/VBox.add_child(CharacterButton)


func _on_MainMenuBtn_pressed():
	get_tree().change_scene("res://Scenes/Interface/Menu_GameStart.tscn")
