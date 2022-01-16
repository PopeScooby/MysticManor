extends CanvasLayer

func _ready():
	$Placement.visible = false
	$Experience.visible = false
	$Items/ItemDescription.visible = false

func _physics_process(delta):
	self.set_char_stats_text()

func _on_Exit_North_pressed():
	var loc_curr_x = Global.PlayerDict["Grid"]["Loc"].x
	var loc_curr_y = Global.PlayerDict["Grid"]["Loc"].y - 1
	Global.MoveDict["Room_Prev"] = Global.PlayerDict["Grid"]["Loc"]
	Global.MoveDict["Dir_Moved"] = "N"
	Global.PlayerDict["Grid"]["Loc"] = Vector2(loc_curr_x, loc_curr_y)
	Global.STATE_PLAYER = "EnteringRoom"

func _on_Exit_East_pressed():
	var loc_curr_x = Global.PlayerDict["Grid"]["Loc"].x + 1
	var loc_curr_y = Global.PlayerDict["Grid"]["Loc"].y
	Global.MoveDict["Room_Prev"] = Global.PlayerDict["Grid"]["Loc"]
	Global.MoveDict["Dir_Moved"] = "E"
	Global.PlayerDict["Grid"]["Loc"] = Vector2(loc_curr_x, loc_curr_y)
	Global.STATE_PLAYER = "EnteringRoom"

func _on_Exit_South_pressed():
	var loc_curr_x = Global.PlayerDict["Grid"]["Loc"].x
	var loc_curr_y = Global.PlayerDict["Grid"]["Loc"].y + 1
	Global.MoveDict["Room_Prev"] = Global.PlayerDict["Grid"]["Loc"]
	Global.MoveDict["Dir_Moved"] = "S"
	Global.PlayerDict["Grid"]["Loc"] = Vector2(loc_curr_x, loc_curr_y)
	Global.STATE_PLAYER = "EnteringRoom"

func _on_Exit_West_pressed():
	var loc_curr_x = Global.PlayerDict["Grid"]["Loc"].x - 1
	var loc_curr_y = Global.PlayerDict["Grid"]["Loc"].y
	Global.MoveDict["Room_Prev"] = Global.PlayerDict["Grid"]["Loc"]
	Global.MoveDict["Dir_Moved"] = "W"
	Global.PlayerDict["Grid"]["Loc"] = Vector2(loc_curr_x, loc_curr_y)
	Global.STATE_PLAYER = "EnteringRoom"

func _on_Exit_Up_pressed():
	Global.STATE_PLAYER = "Stairs_Up"

func _on_Exit_Down_pressed():
	Global.STATE_PLAYER = "Stairs_Down"


func _on_Action_EndTurn_pressed():
	Global.STATE_PLAYER = "EndTurn"

func _on_Action_RotateLeft_pressed():
	Global.STATE_PLAYER = "RoomRotate_Left"

func _on_Action_RotateRight_pressed():
	Global.STATE_PLAYER = "RoomRotate_Right"

func _on_Action_PlaceRoom_pressed():
	Global.STATE_PLAYER = "PlaceRoom"

func _on_Action_pressed():
	if $Experience/Background/Action/ActionText.text.to_upper() == "ROLL":
		$Experience/Background/VBox/CenterBox/HBox_Dice/D6_1.roll_d6()
		Global.STATE_PLAYER = "RollingDice"
	elif $Experience/Background/Action/ActionText.text.to_upper() == "TELEPORT":
		Global.STATE_PLAYER = "Teleport"
	elif $Experience/Background/Action/ActionText.text.to_upper() == "OK":
		Global.STATE_PLAYER = "EndTurn"
	elif $Experience/Background/Action/ActionText.text.to_upper() == "DAMAGE":
		Global.STATE_PLAYER = "TakeDamage"
	elif $Experience/Background/Action/ActionText.text.to_upper() == "ITEM":
		Global.STATE_PLAYER = "ViewItem"
	elif $Experience/Background/Action/ActionText.text.to_upper() == "TAKE":
		Global.STATE_PLAYER = "TakeItem"


func set_char_stats_text():
	$Character/Stat_Amount_Actions/AmountText.text = str(Global.PlayerDict["Stats_Curr"]["Actions"])
	$Character/Stat_Amount_Strength/AmountText.text = str(Global.PlayerDict["Stats_Curr"]["Strength"])
	$Character/Stat_Amount_Dexterity/AmountText.text = str(Global.PlayerDict["Stats_Curr"]["Dexterity"])
	$Character/Stat_Amount_Wits/AmountText.text = str(Global.PlayerDict["Stats_Curr"]["Wits"])
	$Character/Stat_Amount_Intellect/AmountText.text = str(Global.PlayerDict["Stats_Curr"]["Intellect"])
	$Character/CharacterPanel/Name/NameText.text = Global.PlayerDict["Character"]
#	$Character/CharacterPanel/TextureRect.texture = load("")

func set_exit_buttons():

	var RoomNum = Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]]
	var Room_Curr = Rooms.RoomDict[RoomNum]

	$Movement.visible = true
	if Global.PlayerDict["Stats_Curr"]["Actions"] == 0:
		self.hide_exit_buttons()
	else:
		if Room_Curr["Exits"].has("N"):
			$Movement/Exit_North.visible = true
		else:
			$Movement/Exit_North.visible = false

		if Room_Curr["Exits"].has("E"):
			$Movement/Exit_East.visible = true
		else:
			$Movement/Exit_East.visible = false

		if Room_Curr["Exits"].has("S"):
			$Movement/Exit_South.visible = true
		else:
			$Movement/Exit_South.visible = false

		if Room_Curr["Exits"].has("W"):
			$Movement/Exit_West.visible = true
		else:
			$Movement/Exit_West.visible = false

		if Room_Curr["Exits"].has("U"):
			$Movement/Exit_Up.visible = true
		else:
			$Movement/Exit_Up.visible = false

		if Room_Curr["Exits"].has("D"):
			$Movement/Exit_Down.visible = true
		else:
			$Movement/Exit_Down.visible = false

	$Movement/Action_EndTurn.visible = true

func hide_exit_buttons():

	$Movement/Exit_North.visible = false
	$Movement/Exit_East.visible = false
	$Movement/Exit_South.visible = false
	$Movement/Exit_West.visible = false
	$Movement/Exit_Up.visible = false
	$Movement/Exit_Down.visible = false
	$Movement/Action_EndTurn.visible = false



func _on_Item1_pressed():
	self.view_item(1)

func _on_Item2_pressed():
	self.view_item(2)

func _on_Item3_pressed():
	self.view_item(3)

func _on_Item4_pressed():
	self.view_item(4)


func view_item(ItemIdx):
	if Global.PlayerDict["Items"].size() >= ItemIdx:
		if Global.PlayerDict["ViewItem"] == 0:
			$Items/ItemDescription.visible = true
		elif Global.PlayerDict["ViewItem"] == ItemIdx:
			$Items/ItemDescription.visible = false
			Global.PlayerDict["ViewItem"] = 0
			return

		Global.PlayerDict["ViewItem"] = ItemIdx

		ItemIdx -= 1
		var item_id = Global.PlayerDict["Items"][ItemIdx]
		$Items/ItemDescription/ItemName/TitleText.text = Items.ItemDict[item_id]["ItemName"]
		$Items/ItemDescription/ItemText.text = Items.ItemDict[item_id]["ItemText_Main"]


