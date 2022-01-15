extends Node

var STATE_GAME = "PlayerTurn"
var STATE_PLAYER = ""
var STATE_INTERFACE = ""

var CharDict = {}
var PlayerDict = {}
var MysteryDeck = []
var RoomDeck = []
var ExperienceDeck = []
var ItemDeck = []
var HouseDict = {}
var EmptyRooms = {}
var LandingDict = {}
var MoveDict = {}
var EnemyList = {"Boss":
	{
		"EnemyID": "1",
		"EnemyName": "Zombie Cowboy",
		"EnemyType": "Boss",
		"EnemyItem": "",
		"Actions": 1,
		"Grid": {"Floor":0, "Loc":Vector2(2,3)}
	}
}
var RouteDict = {}

var DieResults = {6: [1,2,3,4,5,6]}
var DieRolled = {"D6_1": false, "D6_2": false}
var EmptyRoomDict = {
	0: {
		Vector2(0,-1): {"Dir_Moved":"N"},
		Vector2(1,-1): {"Dir_Moved":"N"},
		Vector2(2,0): {"Dir_Moved":"E"},
		Vector2(0,2): {"Dir_Moved":"S"},
		Vector2(1,2): {"Dir_Moved":"S"}
	},
	1: {
		Vector2(0,-1): {"Dir_Moved":"N"},
		Vector2(1,0): {"Dir_Moved":"E"},
		Vector2(1,1): {"Dir_Moved":"E"},
		Vector2(-1,-1): {"Dir_Moved":"W"},
		Vector2(-1,0): {"Dir_Moved":"W"},
		Vector2(0,2): {"Dir_Moved":"S"}
	}
}


func _ready():
	self.load_saves()

func _process(delta):
	pass

func create_character(CharName, TempStats):
	self.CharDict[CharName] = {
		"Experience": 0,
		"Stats": {
			"Actions": 3,
			"Wits": TempStats["Wits"],
			"Dexterity": TempStats["Dexterity"],
			"Strength": TempStats["Strength"],
			"Intellect": TempStats["Intellect"]
		},
		"SavedItems": [],
		"ActiveGame": {},
		"MysteryDeck": ["1"],
		"Solved": {}
	}
	self.save_game()

func start_random_mystery():
	get_new_dicts()
	self.PlayerDict["Mystery"] = draw_mystery()
	get_tree().change_scene("res://Scenes/Gameplay/Gameboard.tscn")

func new_turn():
	self.reset_move_dict()
	self.PlayerDict["Stats_Curr"]["Actions"] = self.PlayerDict["Actions"] + self.PlayerDict["Stats_Curr"]["Dexterity"]


func get_new_dicts():
#	HouseDict = {
#		0: {Vector2(0,0): "1",Vector2(0,1): "2",Vector2(1,1): "3",Vector2(1,0): "4"},
#		1: {Vector2(0,0): "15",Vector2(0,1): "16"}
#	}
#	EmptyRooms = {
#		0: [Vector2(0,-1), Vector2(1,-1), Vector2(0,2), Vector2(1,2)],
#		1: [Vector2(0,-1), Vector2(1,0), Vector2(1,1), Vector2(-1,-1), Vector2(0,2)]
#	}
	LandingDict = {0: [Vector2(1,0)], 1:[Vector2(0,0)]}
	HouseDict = {
		0: {Vector2(0,0): "1",Vector2(0,1): "2",Vector2(1,1): "3",Vector2(1,0): "4",Vector2(0,2): "11",Vector2(1,2): "20",
			Vector2(0,3): "17",Vector2(1,3): "8",Vector2(2,0): "13",Vector2(2,1): "14",Vector2(2,2): "6",Vector2(2,3): "12"},
		1: {Vector2(0,0): "15",Vector2(0,1): "16"}
	}
	EmptyRooms = {
		0: [Vector2(0,-1), Vector2(1,-1), Vector2(3,0), Vector2(3,3), Vector2(2,4), Vector2(1,4)],
		1: [Vector2(0,-1), Vector2(1,0), Vector2(1,1), Vector2(-1,-1), Vector2(-1,0), Vector2(0,2)]
	}
	MysteryDeck = self.PlayerDict["MysteryDeck"]
	RoomDeck = ["5","6","7","8","9","10","11","12","13","14"]
	ExperienceDeck = ["1","2","3","4","5","6","7","8","9","10"]
	ItemDeck = ["1"]
	self.reset_move_dict()


func set_player_dict(CharName):
	self.PlayerDict = {
		"Character": CharName,
		"Mystery": "",
		"Grid": {"Floor":0, "Loc":Vector2(1,2)},
		"Actions": self.CharDict[CharName]["Stats"]["Actions"],
		"Stats_Original": {
			"Wits": self.CharDict[CharName]["Stats"]["Wits"],
			"Dexterity": self.CharDict[CharName]["Stats"]["Dexterity"],
			"Strength": self.CharDict[CharName]["Stats"]["Strength"],
			"Intellect": self.CharDict[CharName]["Stats"]["Intellect"]},
		"Stats_Curr": {
			"Actions": self.CharDict[CharName]["Stats"]["Dexterity"] + self.CharDict[CharName]["Stats"]["Actions"],
			"Wits": self.CharDict[CharName]["Stats"]["Wits"],
			"Dexterity":self.CharDict[CharName]["Stats"]["Dexterity"],
			"Strength": self.CharDict[CharName]["Stats"]["Strength"],
			"Intellect": self.CharDict[CharName]["Stats"]["Intellect"]},
		"Items": [],
		"MysteryDeck": self.CharDict[CharName]["MysteryDeck"],
		"ViewItem": 0
	}


func reset_move_dict():
	self.MoveDict= {
		"TempRoom":"",
		"Room_Prev": Vector2(),
		"Dir_Moved": "",
		"Rotations": 0,
		"EmptyRooms_New": [],
		"EmptyRoomDict": [],
		"TempExp":"",
		"TempItem": "",
		"ResultOption": "",
		"Damage": {"Stat": "", "Amount": 0}
	}

func reset_route_dict():
	self.RouteDict = {
		"Exits":{}
	}
#	self.RouteDict = {
#		"Exits":{},
#		"Working": {
#			"Exit": "",
#			"Route": [],
#			"Rooms": {}
#		}
#	}

func draw_mystery():
	randomize()
	var new_mystery = self.MysteryDeck[randi() % self.MysteryDeck.size()]
	return new_mystery


func load_saves():
	var save_game = File.new()
	var file_name = "user://save_data.save"
	if not save_game.file_exists(file_name):
		return

	save_game.open(file_name, File.READ)
	CharDict.clear()
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		if current_line!= null:
			CharDict = current_line

	save_game.close()


func save_game():

	var save_game = File.new()
	var file_name = "user://save_data.save"

	save_game.open(file_name, File.WRITE)
	save_game.store_line(to_json(CharDict))
	save_game.close()

#var CharDict = {
#	"PopeScooby": {
#		"Experience": 0,
#		"Stats": {
#			"Actions": 3,
#			"Wits": 3,
#			"Dexterity": 3,
#			"Strength": 3,
#			"Intellect": 3
#		},
#		"SavedItems": [],
#		"ActiveGame": {
#			"Grid": {"Floor":0, "Loc":Vector2(0,0)},
#			"RoomDeck": [],
#			"ExperienceDeck": [],
#			"ItemDeck": [],
#			"HouseDict": {},
#			"EmptyRooms": {},
#			"MysteryActivated": false,
#			"Mystery":{
#				"1": {
#					"MysteryName": "The Crystal Skull (Not that one)",
#					"Trigger": {
#						"Type":"RoomList",
#						"RoomNeed": 3,
#						"Rooms":["5","7","9","11"]
#					},
#					"Experience": "3",
#					"Goal": {"Type": "Location", "Requirements": {"InRoom": "3", "HaveItem": ["5"]}},
#					"Enemies": {"ZombieCowboy": {"Type": "Boss"}}
#				}
#			}
#		},
#		"MysteryDeck": [],
#		"Solved": {}
#	}
#}
#var PlayerDict = {
#	"Character":"PopeScooby",
#	"Mystery": "",
#	"Grid": {"Floor":0, "Loc":Vector2(0,0)},
#	"Actions": 3,
#	"Stats_Original": {"Wits": 3, "Dexterity":3, "Strength": 3, "Intellect": 3},
#	"Stats_Curr": {"Actions": 6, "Wits": 3, "Dexterity":1, "Strength": 4, "Intellect": 4},
#	"Items": []
#}
