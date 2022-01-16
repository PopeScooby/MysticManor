extends Control

var TempStats = {"Strength": 3, "Dexterity": 3, "Wits": 3, "Intellect": 3, "Avail": 0, "Used": 12}

func _ready():
	self._set_stat_text()

func _on_CloseButton_pressed():
	self.visible = false

func _on_NewNameTxt_text_changed(new_text):
	self._set_stat_text()

func _on_Strength_Up_pressed():
	self._set_stat_up("Strength")


func _on_Strength_Down_pressed():
	self._set_stat_down("Strength")


func _on_Dexterity_Up_pressed():
	self._set_stat_up("Dexterity")


func _on_Dexterity_Down_pressed():
	self._set_stat_down("Dexterity")


func _on_Wits_Up_pressed():
	self._set_stat_up("Wits")


func _on_Wits_Down_pressed():
	self._set_stat_down("Wits")


func _on_Intellect_Up_pressed():
	self._set_stat_up("Intellect")


func _on_Intellect_Down_pressed():
	self._set_stat_down("Intellect")

func _on_StartGameBtn_pressed():
	if TempStats["Used"] == 12:
		Global.create_character($Background/VBox/NewNameTxt.text, TempStats)
		Global.set_player_dict($Background/VBox/NewNameTxt.text)
		Global.start_random_mystery()


func _set_stat_up(Stat):
	if TempStats[Stat] < 6 and TempStats["Used"] < 12:
		TempStats[Stat] += 1
		TempStats["Avail"] -= 1
		TempStats["Used"] += 1
		self._set_stat_text()

func _set_stat_down(Stat):
	if TempStats[Stat] > 1:
		TempStats[Stat] -= 1
		TempStats["Avail"] += 1
		TempStats["Used"] -= 1
		self._set_stat_text()

func _set_stat_text():
	$Background/VBox/HBox_Stats/Stat_Amount_Strength/AmountText.text = str(TempStats["Strength"])
	$Background/VBox/HBox_Stats/Stat_Amount_Dexterity/AmountText.text = str(TempStats["Dexterity"])
	$Background/VBox/HBox_Stats/Stat_Amount_Wits/AmountText.text = str(TempStats["Wits"])
	$Background/VBox/HBox_Stats/Stat_Amount_Intellect/AmountText.text = str(TempStats["Intellect"])
	$Background/VBox/HBox_Total/Stat_Amount_Avail/AmountText.text = str(TempStats["Avail"])
	$Background/VBox/HBox_Total/Stat_Amount_Used/AmountText.text = str(TempStats["Used"])
	if TempStats["Used"] == 12 and $Background/VBox/NewNameTxt.text != "" and not Global.CharDict.has($Background/VBox/NewNameTxt.text):
		$Background/VBox/StartGameBtn.visible = true
	else:
		$Background/VBox/StartGameBtn.visible = false

