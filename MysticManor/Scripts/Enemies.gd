extends Node

var EnemiesDict = {}

func _add_enemy_dict(enemy_key, enemy_name):
	self.EnemiesDict[enemy_key] = {
		"EnemyName": enemy_name,
		"EnemyType": "Boss",
		"EnemyItem": "",
		"Actions": 3,
		"Grid": {"Floor":0, "Loc":Vector2(2,3)}
	}

func _set_enemies():
	
	var key = 0
	var enemy_key = str(key)

	key += 1
	enemy_key = str(key)
	self._add_enemy_dict(enemy_key, "Zombie Cowboy")
	
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
