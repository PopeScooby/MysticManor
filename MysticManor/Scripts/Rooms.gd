extends Node

var RoomDict = {}
var Exits = {"N":{"Enter_Dir":"S","Rotate_Right":"E","Rotate_Left":"W", "VectorMod": Vector2(0,-1)},
			 "S":{"Enter_Dir":"N","Rotate_Right":"W","Rotate_Left":"E", "VectorMod": Vector2(0,1)},
			 "E":{"Enter_Dir":"W","Rotate_Right":"S","Rotate_Left":"N", "VectorMod": Vector2(1,0)},
			 "W":{"Enter_Dir":"E","Rotate_Right":"N","Rotate_Left":"S", "VectorMod": Vector2(-1,0)}}

func _ready():
	self._set_rooms()

func _add_room_dict(room_key, room_name):
	self.RoomDict[room_key] = {
		"RoomName": room_name,
		"RoomType": "",
		"Floors": {},
		"Exits": {},
		"ExitRooms": {},
		"HasExperience": true,
		"IsEmpty": false,
		"IsOutside": false,
		"Obsticles": {},
		"Items": {},
		"Events": {},
		"Enemies": {},
		"Grid": {"Floor": null, "Loc": Vector2(), "Rotations": 0}
		}

func _set_rooms():
	var room_key = "1"

	self._add_room_dict(room_key, "Entryway1")
	RoomDict[room_key]["RoomType"] = "Enterance"
	RoomDict[room_key]["Floors"] = ["G"]
	RoomDict[room_key]["Exits"] = ["N","S","E"]
	RoomDict[room_key]["Grid"]["Loc"] = Vector2(0,0)

	room_key = "2"
	self._add_room_dict(room_key, "Entryway2")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G"]
	RoomDict[room_key]["Exits"] = ["N","S","E"]
	RoomDict[room_key]["Grid"]["Loc"] = Vector2(0,1)

	room_key = "3"
	self._add_room_dict(room_key, "Entryway4")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G"]
	RoomDict[room_key]["Exits"] = ["N","S","W","D"]
	RoomDict[room_key]["ExitRooms"] = {"D": {"Floor":-1,"Loc":Vector2(0,0)}}
	RoomDict[room_key]["Grid"]["Loc"] = Vector2(1,1)

	room_key = "4"
	self._add_room_dict(room_key, "Entryway3")
	RoomDict[room_key]["RoomType"] = "Landing"
	RoomDict[room_key]["Floors"] = ["G"]
	RoomDict[room_key]["Exits"] = ["N","S","W","U"]
	RoomDict[room_key]["ExitRooms"] = {"U": {"Floor":1,"Loc":Vector2(0,0)}}
	RoomDict[room_key]["Grid"]["Loc"] = Vector2(1,0)

	room_key = "5"
	self._add_room_dict(room_key, "DiningRoom")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["E","W"]

	room_key = "6"
	self._add_room_dict(room_key, "Library")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","S"]

	room_key = "7"
	self._add_room_dict(room_key, "MasterBedroom")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","S","E"]

	room_key = "8"
	self._add_room_dict(room_key, "Kitchen")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["S","E","W"]

	room_key = "9"
	self._add_room_dict(room_key, "Study")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["S","E"]

	room_key = "10"
	self._add_room_dict(room_key, "ReadingNook")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["S","E","W"]

	room_key = "11"
	self._add_room_dict(room_key, "Bathroom")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["S","E"]

	room_key = "12"
	self._add_room_dict(room_key, "HallwayX")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","S","E","W"]

	room_key = "13"
	self._add_room_dict(room_key, "HallwayT")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["S","E","W"]

	room_key = "14"
	self._add_room_dict(room_key, "HallwayI")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","S"]

	room_key = "15"
	self._add_room_dict(room_key, "Landing_1")
	RoomDict[room_key]["RoomType"] = "Landing"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","S","E","D"]
	RoomDict[room_key]["ExitRooms"] = {"D": {"Floor":0,"Loc":Vector2(1,0)}}

	room_key = "16"
	self._add_room_dict(room_key, "Landing_1")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","S","E","W"]
	RoomDict[room_key]["ExitRooms"] = {"D": {"Floor":0,"Loc":Vector2(1,1)}}

	room_key = "17"
	self._add_room_dict(room_key, "Chapel")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","E"]
	RoomDict[room_key]["ExitRooms"] = {}

	room_key = "18"
	self._add_room_dict(room_key, "MusicRoom")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["W"]
	RoomDict[room_key]["ExitRooms"] = {}

	room_key = "19"
	self._add_room_dict(room_key, "Pantry")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","E","W"]
	RoomDict[room_key]["ExitRooms"] = {}

	room_key = "20"
	self._add_room_dict(room_key, "ArcaneLab")
	RoomDict[room_key]["RoomType"] = "Room"
	RoomDict[room_key]["Floors"] = ["G","A","B"]
	RoomDict[room_key]["Exits"] = ["N","W"]
	RoomDict[room_key]["ExitRooms"] = {}

func find_room_exit_right():

	if not Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"].has(Rooms.Exits[Global.MoveDict["Dir_Moved"]]["Enter_Dir"]):
		self.rotate_room_right()

func rotate_room_right():

	var exits_new = []
	var exits_curr = Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"]

	for exit in exits_curr:
		exits_new.append(Rooms.Exits[exit]["Rotate_Right"])

	Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"] = exits_new

	if Global.MoveDict["Rotations"] == 3:
		Global.MoveDict["Rotations"] = 0
	else:
		Global.MoveDict["Rotations"] += 1

	if not Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"].has(Rooms.Exits[Global.MoveDict["Dir_Moved"]]["Enter_Dir"]):
		self.rotate_room_right()

func find_room_exit_left():

	if not Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"].has(Rooms.Exits[Global.MoveDict["Dir_Moved"]]["Enter_Dir"]):
		self.rotate_room_left()

func rotate_room_left():

	var exits_new = []
	var exits_curr = Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"]

	for exit in exits_curr:
		exits_new.append(Rooms.Exits[exit]["Rotate_Left"])

	Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"] = exits_new

	if Global.MoveDict["Rotations"] == 0:
		Global.MoveDict["Rotations"] = 3
	else:
		Global.MoveDict["Rotations"] -= 1

	if not Rooms.RoomDict[Global.MoveDict["TempRoom"]]["Exits"].has(Rooms.Exits[Global.MoveDict["Dir_Moved"]]["Enter_Dir"]):
		self.rotate_room_left()
