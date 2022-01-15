extends TextureRect


func _ready():
	pass

func roll_d6():
	Global.DieRolled[self.name] = false
	var die_result = self.get_d6_result()
	$AnimationPlayer.play("DieRoll_" + str(die_result))


func get_d6_result():

	var die_key = Experiences.ExperienceDict[Global.MoveDict["TempExp"]]["Dice"]

	randomize()
	Global.MoveDict["RollResult"] = Global.DieResults[die_key][randi() % (die_key)]
	var die_result = Global.MoveDict["RollResult"]
	return die_result


func _on_AnimationPlayer_animation_finished(anim_name):
	Global.DieRolled[self.name] = true
