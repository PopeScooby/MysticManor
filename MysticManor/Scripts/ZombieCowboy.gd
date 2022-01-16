extends Sprite


export var enemy_name = "Boss"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.EnemyList[enemy_name]["Grid"]["Floor"] == Global.PlayerDict["Grid"]["Floor"]:
		self.visible = true
	else:
		self.visible = false
