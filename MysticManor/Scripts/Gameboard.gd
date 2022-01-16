extends Node2D



func _ready():
	self.set_char_floor()
	self.set_char_pos()
	$GameplayInterface.set_exit_buttons()

func _process(delta):
	_exec_state()


func _exec_state():

	if Global.STATE_PLAYER == "EnteringRoom":
		self._exec_state_entering_room()
	elif Global.STATE_PLAYER == "EndTurn":
		self._exec_state_end_turn()
	elif Global.STATE_PLAYER == "RevealRoom":
		self._exec_state_reveal_room()
	elif Global.STATE_PLAYER == "RoomPlacement":
		self._exec_state_room_placement()
	elif Global.STATE_PLAYER == "PlaceRoom":
		self._exec_state_place_room()
	elif Global.STATE_PLAYER == "RoomRotate_Right":
		self._exec_state_room_rotate_right()
	elif Global.STATE_PLAYER == "RoomRotate_Left":
		self._exec_state_room_rotate_right()
	elif Global.STATE_PLAYER == "Experience_Start":
		self._exec_state_experience_start()
	elif Global.STATE_PLAYER == "RollingDice" and Global.DieRolled["D6_1"]:
		self._exec_state_rolling_dice()
	elif Global.STATE_PLAYER == "Stairs_Up":
		self._exec_state_stairs_up()
	elif Global.STATE_PLAYER == "Stairs_Down":
		self._exec_state_stairs_down()
	elif Global.STATE_PLAYER == "Teleport":
		self._exec_state_teleport()
	elif Global.STATE_PLAYER == "TakeDamage":
		self._exec_state_take_damage()
	elif Global.STATE_PLAYER == "ViewItem":
		self._exec_state_view_item()
	elif Global.STATE_PLAYER == "TakeItem":
		self._exec_state_take_item()
	elif Global.STATE_PLAYER == "EnemyMoveStart":
		self._exec_state_enemy_move()

func _exec_state_entering_room():

	self.set_char_pos()
	Global.PlayerDict["Stats_Curr"]["Actions"] -= 1
	if Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]].has(Global.PlayerDict["Grid"]["Loc"]):
		Global.STATE_PLAYER = "CheckRoom"
		$GameplayInterface.set_exit_buttons()
	else:
		$GameplayInterface/Movement.visible = false
		Global.STATE_PLAYER = "RevealRoom"

func _exec_state_reveal_room():
	Global.STATE_PLAYER = ""
	$GameplayInterface.hide_exit_buttons()
	if Global.RoomDeck.size() > 0:
		Global.STATE_PLAYER = "RoomPlacement"

func _exec_state_room_placement():
	Global.MoveDict["TempRoom"] = self.draw_room_tile()
	Rooms.find_room_exit_right()
	Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]] = Global.MoveDict["TempRoom"]
	self._set_room_rotation()
	self._set_empty_rooms()
	$GameplayInterface/Placement.visible = true
	Global.STATE_PLAYER = ""

func _exec_state_room_rotate_right():
	Rooms.rotate_room_right()
	self._set_room_rotation()
	self._set_empty_rooms()
	Global.STATE_PLAYER = ""

func _exec_state_room_rotate_left():
	Rooms.rotate_room_left()
	self._set_room_rotation()
	self._set_empty_rooms()
	Global.STATE_PLAYER = ""

func _exec_state_place_room():
	self._set_room_rotation()
	self._set_empty_rooms()
	Global.RoomDeck.erase(Global.MoveDict["TempRoom"])
	Global.EmptyRooms[Global.PlayerDict["Grid"]["Floor"]].erase(Global.PlayerDict["Grid"]["Loc"])
	Global.EmptyRoomDict[Global.PlayerDict["Grid"]["Floor"]].erase(Global.PlayerDict["Grid"]["Loc"])
	Global.EmptyRooms[Global.PlayerDict["Grid"]["Floor"]].append_array(Global.MoveDict["EmptyRooms_New"])
	for empty_room_dict in Global.MoveDict["EmptyRoomDict"]:
		Global.EmptyRoomDict[Global.PlayerDict["Grid"]["Floor"]][empty_room_dict["Loc"]] = {"Dir_Moved": empty_room_dict["Dir_Moved"]}

	$GameplayInterface/Placement.visible = false
	if Rooms.RoomDict[Global.MoveDict["TempRoom"]]["HasExperience"]:
		Global.reset_move_dict()
		Global.STATE_PLAYER = "Experience_Start"
	else:
		$GameplayInterface.set_exit_buttons()
		Global.reset_move_dict()
		Global.STATE_PLAYER = ""

func _exec_state_experience_start():
	Global.MoveDict["TempExp"] = self.draw_experience()
	Global.ExperienceDeck.erase(Global.MoveDict["TempExp"])
	$GameplayInterface/Movement.visible = false
	$GameplayInterface/Experience/Background/VBox/ResultText.visible = false
	$GameplayInterface/Experience/Background/Title/TitleText.text = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["ExperienceName"]
	$GameplayInterface/Experience/Background/VBox/MainText.visible = true
	$GameplayInterface/Experience/Background/VBox/MainText.text = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["ExperienceText_Story"]
	$GameplayInterface/Experience/Background/VBox/RollText.visible = true
	$GameplayInterface/Experience/Background/VBox/RollText.text = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["Action_Text"]
	$GameplayInterface/Experience/Background/VBox/CenterBox/HBox_Dice.visible = true
	$GameplayInterface/Experience/Background/VBox/CenterBox/HBox_Dice/D6_1.visible = true
	$GameplayInterface/Experience/Background/VBox/CenterBox/HBox_Dice/StatText.visible = true
	if Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["Stat"] == "":
		$GameplayInterface/Experience/Background/VBox/CenterBox/HBox_Dice/StatText.text = ""
	else:
		$GameplayInterface/Experience/Background/VBox/CenterBox/HBox_Dice/StatText.text = " + " + Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["Stat"] + "(" + str(Global.PlayerDict["Stats_Curr"][Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["Stat"]]) + ")"
	$GameplayInterface/Experience/Background/Action/ActionText.text = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["ResultType"]
	$GameplayInterface/Experience.visible = true
	Global.STATE_PLAYER = ""

func _exec_state_rolling_dice():
	$GameplayInterface/Experience/Background/VBox/MainText.visible = false
	$GameplayInterface/Experience/Background/VBox/RollText.visible = false
#	$GameplayInterface/Experience_Area/Btn_Action.visible = false
	$GameplayInterface/Experience/Background/VBox/ResultText.visible = true
	for result_option in Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["ResultOptions_Roll"]:
		Global.MoveDict["ResultOption"] = result_option
		var result = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["ResultOptions_Roll"][result_option]
		var roll_total
		if Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["Stat"] == "":
			roll_total = Global.MoveDict["RollResult"]
		else:
			roll_total = Global.MoveDict["RollResult"] + Global.PlayerDict["Stats_Curr"][Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["Stat"]]

		if roll_total >= result["Roll_Min"] and roll_total <= result["Roll_Max"]:
			$GameplayInterface/Experience/Background/VBox/ResultText.text = result["Text"]
			$GameplayInterface/Experience/Background/Action/ActionText.text = result["Text_Button"]
			return
	pass

	Global.STATE_PLAYER = ""

func _exec_state_stairs_up():

	var room_num = Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]]
	var new_floor = Rooms.RoomDict[room_num]["ExitRooms"]["U"]["Floor"]
	var new_loc = Rooms.RoomDict[room_num]["ExitRooms"]["U"]["Loc"]

	Global.PlayerDict["Grid"]["Floor"] = new_floor
	Global.PlayerDict["Grid"]["Loc"] = new_loc
	self.set_char_floor()
	Global.STATE_PLAYER = "EnteringRoom"

func _exec_state_stairs_down():

	var room_num = Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]]
	var new_floor = Rooms.RoomDict[room_num]["ExitRooms"]["D"]["Floor"]
	var new_loc = Rooms.RoomDict[room_num]["ExitRooms"]["D"]["Loc"]

	Global.PlayerDict["Grid"]["Floor"] = new_floor
	Global.PlayerDict["Grid"]["Loc"] = new_loc
	self.set_char_floor()
	Global.STATE_PLAYER = "EnteringRoom"

func _exec_state_end_turn():
	$GameplayInterface/Experience.visible = false
	Global.STATE_PLAYER = "EnemyMoveStart"
#	Global.new_turn()
#	$GameplayInterface.set_exit_buttons()

func _exec_state_teleport():
	self._set_room_random_new()
	self.set_char_floor()
	$GameplayInterface/Experience.visible = false
	Global.STATE_PLAYER = "EnteringRoom"

func _exec_state_take_damage():

	var damage_stat = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["ResultOptions_Roll"][Global.MoveDict["ResultOption"]]["Damage"]["Stat"]
	var damage_amount = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["ResultOptions_Roll"][Global.MoveDict["ResultOption"]]["Damage"]["Amount"]

	Global.PlayerDict["Stats_Curr"][damage_stat] -= damage_amount
	$GameplayInterface/Experience.visible = false
	$GameplayInterface.set_exit_buttons()
	Global.STATE_PLAYER = ""

func _exec_state_view_item():
	var new_item = draw_item()
	Global.MoveDict["TempItem"] = new_item
	$GameplayInterface/Movement.visible = false
	$GameplayInterface/Experience/Background/VBox/ResultText.visible = false
	$GameplayInterface/Experience/Background/Title/TitleText.text = Items.ItemDict[new_item]["ItemName"]
	$GameplayInterface/Experience/Background/VBox/MainText.visible = true
	$GameplayInterface/Experience/Background/VBox/MainText.text = Items.ItemDict[new_item]["ItemText_Main"]
	$GameplayInterface/Experience/Background/VBox/RollText.visible = false
	$GameplayInterface/Experience/Background/VBox/CenterBox/HBox_Dice.visible = false
	$GameplayInterface/Experience/Background/Action/ActionText.text = "Take"
	$GameplayInterface/Experience.visible = true
	Global.STATE_PLAYER = ""

func _exec_state_take_item():
	var new_item = Global.MoveDict["TempItem"]
	Global.PlayerDict["Items"].append(new_item)
	Global.ItemDeck.remove(new_item)
	var item_node = get_node("GameplayInterface/Items/Item" + str(Global.PlayerDict["Items"].size()) + "/ItemText")
	item_node.text = Items.ItemDict[new_item]["ItemName"]
	$GameplayInterface/Experience.visible = false
	$GameplayInterface.set_exit_buttons()
	Global.STATE_PLAYER = ""

func _exec_state_enemy_move():
	for enemy in Global.EnemyList:
		var curr_actions = Global.EnemyList[enemy]["Actions"]
		while curr_actions > 0:
			curr_actions -= 1
			var move_dir = _get_enemy_route(enemy)
			if Rooms.Exits[move_dir]["Type"] == "Door":
				Global.EnemyList[enemy]["Grid"]["Loc"] = Global.EnemyList[enemy]["Grid"]["Loc"] + Rooms.Exits[move_dir]["VectorMod"]
			elif Rooms.Exits[move_dir]["Type"] == "LevelChange":
				Global.EnemyList[enemy]["Grid"]["Floor"] = Global.RouteDict["EnemyRoom"]["ExitRooms"][move_dir]["Floor"]
				Global.EnemyList[enemy]["Grid"]["Loc"] = Global.RouteDict["EnemyRoom"]["ExitRooms"][move_dir]["Loc"]
			set_enemy_pos(enemy)
	Global.new_turn()
	$GameplayInterface.set_exit_buttons()
	Global.STATE_PLAYER = ""

func set_char_pos():

	var grid_loc = Global.PlayerDict["Grid"]["Loc"]
	var new_pos_x = 322 + (grid_loc.x * 640)
	var new_pos_y = 322 + (grid_loc.y * 640)

	$Adventurer.position = Vector2(new_pos_x, new_pos_y)

func set_enemy_pos(enemy):

	var grid_loc = Global.EnemyList[enemy]["Grid"]["Loc"]
	var new_pos_x = 322 + (grid_loc.x * 640)
	var new_pos_y = 322 + (grid_loc.y * 640)
	var enemy_node = get_node("Enemies/" + enemy)
	enemy_node.position = Vector2(new_pos_x, new_pos_y)

func set_char_floor():

	if Global.PlayerDict["Grid"]["Floor"] == 0:
		$GroundFloor.visible = true
	else:
		$GroundFloor.visible = false


	if Global.PlayerDict["Grid"]["Floor"] == 1:
		$SecondFloor.visible = true
	else:
		$SecondFloor.visible = false

func _set_room_rotation():

	var floor_node = _get_floor_node()

	if Global.MoveDict["Rotations"] == 0:
		floor_node.set_cellv(Global.PlayerDict["Grid"]["Loc"], int(Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]]),false,false,false)
	elif Global.MoveDict["Rotations"] == 1:
		floor_node.set_cellv(Global.PlayerDict["Grid"]["Loc"], int(Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]]),true,false,true)
	elif Global.MoveDict["Rotations"] == 2:
		floor_node.set_cellv(Global.PlayerDict["Grid"]["Loc"], int(Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]]),true,true,false)
	elif Global.MoveDict["Rotations"] == 3:
		floor_node.set_cellv(Global.PlayerDict["Grid"]["Loc"], int(Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]][Global.PlayerDict["Grid"]["Loc"]]),false,true,true)
	Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Grid"]["Rotations"] = Global.MoveDict["Rotations"]

func _set_empty_rooms():

	var grid_loc = Global.PlayerDict["Grid"]["Loc"]
	var grid_loc_x = grid_loc.x
	var grid_loc_y = grid_loc.y
	var floor_node = _get_floor_node()
	var empty_room_locs = [Vector2(grid_loc_x - 1,grid_loc_y), Vector2(grid_loc_x + 1,grid_loc_y), Vector2(grid_loc_x,grid_loc_y - 1), Vector2(grid_loc_x,grid_loc_y + 1)]
	for empty_room_loc in empty_room_locs:
		if not Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]].has(empty_room_loc) and not Global.EmptyRooms[Global.PlayerDict["Grid"]["Floor"]].has(empty_room_loc):

			floor_node.set_cellv(empty_room_loc, -1,false,false,false)

	Global.MoveDict["EmptyRooms_New"] = []
	for room_exit in Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"]:

		grid_loc_x = grid_loc.x
		grid_loc_y = grid_loc.y

		if room_exit == "N":
			grid_loc_y -= 1
		elif room_exit == "E":
			grid_loc_x += 1
		elif room_exit == "S":
			grid_loc_y += 1
		elif room_exit == "W":
			grid_loc_x -= 1

		if not Global.HouseDict[Global.PlayerDict["Grid"]["Floor"]].has(Vector2(grid_loc_x,grid_loc_y)) and not Global.EmptyRooms[Global.PlayerDict["Grid"]["Floor"]].has(Vector2(grid_loc_x,grid_loc_y)):
			Global.MoveDict["EmptyRoomDict"].append({"Loc":Vector2(grid_loc_x,grid_loc_y), "Dir_Moved":Global.MoveDict["Dir_Moved"]})
			Global.MoveDict["EmptyRooms_New"].append(Vector2(grid_loc_x,grid_loc_y))
			floor_node.set_cellv(Vector2(grid_loc_x,grid_loc_y), 0,false,false,false)

func _set_room_random_new():
	randomize()
	var new_floor = (randi() % Global.EmptyRooms.size())
	randomize()
	var new_room_loc =  Global.EmptyRooms[new_floor][randi() % Global.EmptyRooms[new_floor].size()]
	Global.MoveDict["Room_Prev"] = Global.PlayerDict["Grid"]["Loc"]
	Global.PlayerDict["Grid"]["Floor"] = new_floor
	Global.PlayerDict["Grid"]["Loc"] = new_room_loc
	Global.MoveDict["Dir_Moved"] =  Global.EmptyRoomDict[new_floor][new_room_loc]["Dir_Moved"]


func _get_floor_node():

	var floor_node

	if Global.PlayerDict["Grid"]["Floor"] == 0:
		floor_node = $GroundFloor
	elif Global.PlayerDict["Grid"]["Floor"] == 1:
		floor_node = $SecondFloor

	return floor_node

func _get_enemy_route(enemy):
	Global.reset_route_dict()
	var enemy_dict = Global.EnemyList[enemy]
	Global.RouteDict["EnemyFloor"] = enemy_dict["Grid"]["Floor"]
	Global.RouteDict["EnemyLoc"] = enemy_dict["Grid"]["Loc"]
	Global.RouteDict["StartRoomID"] = Global.HouseDict[Global.RouteDict["EnemyFloor"]][Global.RouteDict["EnemyLoc"]]
	Global.RouteDict["EnemyRoom"] = Rooms.RoomDict[Global.RouteDict["StartRoomID"]]
	Global.RouteDict["CheckedRooms"] = {
		0:[],
		1:[]}
	for room_exit in Global.RouteDict["EnemyRoom"]["Exits"]:
		if Rooms.Exits.has(room_exit):
			if Rooms.Exits[room_exit]["Type"] == "Door":
				var check_loc = Global.RouteDict["EnemyLoc"] + Rooms.Exits[room_exit]["VectorMod"]
				if not Global.EmptyRooms[Global.RouteDict["EnemyFloor"]].has(check_loc):
					Global.RouteDict["Exits"][room_exit] = {
						"Curr": {},
						"Next": {Global.RouteDict["EnemyFloor"]:[check_loc]}
					}
			elif Rooms.Exits[room_exit]["Type"] == "LevelChange":
				var check_loc = Rooms.RoomDict[Global.HouseDict[Global.RouteDict["EnemyFloor"]][Global.RouteDict["EnemyLoc"]]]["ExitRooms"][room_exit]["Loc"]
				var check_floor = Rooms.RoomDict[Global.HouseDict[Global.RouteDict["EnemyFloor"]][Global.RouteDict["EnemyLoc"]]]["ExitRooms"][room_exit]["Floor"]
				if not Global.EmptyRooms[check_floor].has(check_loc):
					Global.RouteDict["Exits"][room_exit] = {
						"Curr": {},
						"Next": {check_floor:[check_loc]}
					}
	Global.RouteDict["CheckedRooms"][Global.RouteDict["EnemyFloor"]].append(Global.RouteDict["EnemyLoc"])
	return _get_route_dir()

func _get_route_dir():
	for room_exit in Global.RouteDict["Exits"]:
		Global.RouteDict["Exits"][room_exit]["Curr"] = Global.RouteDict["Exits"][room_exit]["Next"]
		var curr_rooms = Global.RouteDict["Exits"][room_exit]["Curr"]
		var next_rooms = {}
		for curr_floor in curr_rooms:
			for curr_loc in curr_rooms[curr_floor]:
				if curr_floor == Global.PlayerDict["Grid"]["Floor"] and curr_loc == Global.PlayerDict["Grid"]["Loc"]:
					return room_exit
				else:
					var curr_room_key = Global.HouseDict[curr_floor][curr_loc]
					for exit in Rooms.RoomDict[curr_room_key]["Exits"]:
						if Rooms.Exits.has(exit):
							if Rooms.Exits[exit]["Type"] == "Door":
								var check_loc = curr_loc + Rooms.Exits[exit]["VectorMod"]
								if not Global.EmptyRooms[curr_floor].has(check_loc) and not Global.RouteDict["CheckedRooms"][curr_floor].has(check_loc):
									if not next_rooms.has(curr_floor):
										next_rooms[curr_floor] = []
									if not next_rooms[curr_floor].has(check_loc):
										next_rooms[curr_floor].append(check_loc)
							elif Rooms.Exits[exit]["Type"] == "LevelChange":
								var check_loc = Rooms.RoomDict[curr_room_key]["ExitRooms"][exit]["Loc"]
								var check_floor = Rooms.RoomDict[curr_room_key]["ExitRooms"][exit]["Floor"]
								if not Global.EmptyRooms[check_floor].has(check_loc) and not Global.RouteDict["CheckedRooms"][check_floor].has(check_loc):
									if not next_rooms.has(check_floor):
										next_rooms[check_floor] = []
									if not next_rooms[check_floor].has(check_loc):
										next_rooms[check_floor].append(check_loc)
					Global.RouteDict["CheckedRooms"][curr_floor].append(curr_loc)
		Global.RouteDict["Exits"][room_exit]["Next"] = next_rooms
	return _get_route_dir()


func draw_room_tile():
	randomize()
	var new_room = Global.RoomDeck[randi() % Global.RoomDeck.size()]
	return new_room

func draw_experience():
	randomize()
	var new_experience = Global.ExperienceDeck[randi() % Global.ExperienceDeck.size()]
	return new_experience

func draw_item():
	randomize()
	var new_item = Global.ItemDeck[randi() % Global.ItemDeck.size()]
	return new_item
