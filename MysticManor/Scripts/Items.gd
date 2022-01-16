extends Node

var ItemDict = {}

func _ready():

	var item_key = ""

	item_key = "1"
	self._add_item_dict(item_key, "Unmarked Potion")
	self.ItemDict[item_key]["ItemText_Main"] = "This small container of green liquid has no markings anywhere on it that might inform you as to it's contents. A little voice inside you tells you there is a chance "


func _add_item_dict(item_key, item_name):
	self.ItemDict[item_key] = {
		"ItemName": item_name,
		"ItemText_Main": ""
		}
