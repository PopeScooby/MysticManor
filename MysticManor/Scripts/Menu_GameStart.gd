extends Control

var selector_curr = 1
var selector_locations = {1:217, 2:526, 3:824}

func _ready():
	pass
#	self._move_selector()

func _physics_process(delta):
	$NewGameBtn.visible = not $Menu_NewGame.visible
	$QuitGameBtn.visible = not $Menu_NewGame.visible
	$ContinueBtn.visible = not $Menu_NewGame.visible


func _on_NewGameBtn_pressed():
	if $Menu_NewGame.visible == false:
		_new_game()

func _on_ContinueBtn_pressed():
	if $Menu_NewGame.visible == false:
		_continue()

func _on_QuitGameBtn_pressed():
	if $Menu_NewGame.visible == false:
		get_tree().quit()

func _new_game():
	$Menu_NewGame.visible = true
	$Menu_NewGame/Background/VBox/NewNameTxt.grab_focus()

func _continue():
#	Global.set_player_dict("Butt Chapman")
#	Global.start_random_mystery()
	get_tree().change_scene("res://Scenes/Interface/Menu_CharacterSelect.tscn")



