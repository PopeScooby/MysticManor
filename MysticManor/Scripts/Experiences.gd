extends Node

var ExperienceDict = {}

func _ready():
	self._set_experiences()

func _add_experience_dict(experience_key, experience_name):
	self.ExperienceDict[experience_key] = {
		"ExperienceName": experience_name,
		"ExperienceText_Story": "",
		"Action_Text": "",
		"ResultType": "",
		"ResultOptions_Roll": {},
		"Dice": 6,
		"Stat": ""
		}

func _set_experiences():

	var key = 0
	var experience_key = str(key)

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Smoke Cloud")
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "As you enter, a cloud of smoke forms in the corner of the room. From within the smoke you here a voice beckoning, 'Come to me, let me envelope you.'"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die and add your Wits"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 4,
		"Text": "Almost in a trance you move forward and enter the billowing smoke. The world swirls around you, for a moment you feel dizzy and weightless. When your vision clears you find yourself in a completely different room.",
		"Text_Button": "Teleport"}
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["2"] = {
		"Roll_Min": 5,
		"Roll_Max": 12,
		"Text": "You Move to enter the smokey void, but just before you enter the smoke disapates and in Item falls to the floor.",
		"Text_Button": "Item"}
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["3"] = {
		"Roll_Min": 7,
		"Roll_Max": 12,
		"Text": "You begin to walk toward the smoke, feeling it's pull, but as you are about to enter you regain control of your senses and decide it's best to continue on your way.",
		"Text_Button": "OK"}
#	self.ExperienceDict[experience_key]["Dice"].append(6)
	self.ExperienceDict[experience_key]["Stat"] = "Wits"

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Dart Trap")
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "While walking accross the room you hear a click as your foot hits the floor. Then, in the side of your view you see a dart shoot out of the wall at you."
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die and add your Dexterity"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 5,
		"Text": "You try to move out of the way but aren't quick enough. The point of the dart scratches your arm as it flys by. Immediately you realize the dart was poisoned, as you feel your thoughts grow duller (lose 1 Intelligence)",
		"Text_Button": "Damage",
		"Damage": {"Stat":"Intellect", "Amount": 1}}
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["2"] = {
		"Roll_Min": 6,
		"Roll_Max": 12,
		"Text": "You dive to floor and safety, though you could feel the wind of the dart flying past as you fell.",
		"Text_Button": "OK"}
#	self.ExperienceDict[experience_key]["Dice"].append(6)
	self.ExperienceDict[experience_key]["Stat"] = "Dexterity"

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}

	key += 1
	experience_key = str(key)
	self._add_experience_dict(experience_key, "Blank" + experience_key)
	self.ExperienceDict[experience_key]["ExperienceText_Story"] = "Placeholder"
	self.ExperienceDict[experience_key]["Action_Text"] = "Roll a 6 sided die"
	self.ExperienceDict[experience_key]["ResultType"] = "Roll"
	self.ExperienceDict[experience_key]["ResultOptions_Roll"]["1"] = {
		"Roll_Min": 1,
		"Roll_Max": 12,
		"Text": "Placeholder",
		"Text_Button": "OK"}
